Return-Path: <netdev+bounces-54041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4080E805B3E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA021280A0D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8B68B7B;
	Tue,  5 Dec 2023 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=sanganaka@siddh.me header.b="l9wajJRg"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 09:40:52 PST
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE930109
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:40:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701797109; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=OwXrFQnRWMbGKXs8+HL02CBt0q/f5RKkQDyviQYEdqHjeyAMXS8C6mOybvaoDDB3bLhCPiZUE2jsJEaOolZlgrQ8RXz0O5wlkqFwh6E462VqztysizNqm3mJVrqnLr03xwciAKEQL7W1nvfFcg0A0E7PRW5pMqOap28i5PzwMXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701797109; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7fNJOsQyKCJVxDU+kYFvWKqAIRtDrz/rvo42UT74Mac=; 
	b=IxBSawQdPPq8g1pvb2hMR1YuPckMEyMuFpGYZYh1FEaVafAxHPoZby/QALQjj+xjV//E/1JjFWIc8Wl0oxBglckib+1jEwAUSEj3AD5nhStECZGDu1efpa31vL7M6Ro3RNjHcB+PnAahp8kiUOrHmkBXahZPA0gVzOMR+4GgMLE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=sanganaka@siddh.me;
	dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701797109;
	s=zmail; d=siddh.me; i=sanganaka@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7fNJOsQyKCJVxDU+kYFvWKqAIRtDrz/rvo42UT74Mac=;
	b=l9wajJRg1RGLagwq0LbP4ikyzJZF07oyPucg+1i24ZTormJdkw6/mw4LEqvzsAgL
	qZgf6VcXm1YZt7R8mqSM1HYcPzSWUsfmvnLR9vCH4lJG3E3cAZq1LqX+6S59KXgoKxa
	zAtUsm5rOCLhdQIyNG5rN4Bfu8ZHdKrcysexWeks=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1701797077500517.4638203688928; Tue, 5 Dec 2023 22:54:37 +0530 (IST)
Date: Tue, 05 Dec 2023 22:54:37 +0530
From: Siddh Raman Pant <sanganaka@siddh.me>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Suman Ghosh" <sumang@marvell.com>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"syzbot+bbe84a4010eeea00982d"
 <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c3b02a1ef.6fec9cb996724.8771055654191224615@siddh.me>
In-Reply-To: <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me> <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org> <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
Subject: Re: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On Tue, 05 Dec 2023 22:51:17 +0530, Siddh Raman Pant wrote:
> I agree, it was something I thought about as well. There should be a
> new function for refcount increment. Maybe the existing one could be
> renamed to nfc_get_device_from_idx() and a new nfc_get_device() be
> defined.

Or nfc_find_device() instead of nfc_get_device_from_idx().

Thanks,
Siddh

