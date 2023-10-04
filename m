Return-Path: <netdev+bounces-37984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E67B830C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E9282B20841
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1418E04;
	Wed,  4 Oct 2023 14:58:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8A6128
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:58:45 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939CAB;
	Wed,  4 Oct 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ItaLEz8yYofv11YCURyJNHQx1l8I20bDLTqN6Rxdd18=;
	t=1696431523; x=1697641123; b=V8UOdtE6xNiCDdn57mg2rZW1wknmRZhcWWKzURhlpGXn0xL
	AP+N0SPBViYfmIxwNOBfLsMIrBRI/ripJk1Yc1mUSP5CZr71arfZ/xOC4zA4u0U+1ibnGg7zlZQVJ
	AW19LyyeftKStRpcvyC0aTjt705Z76vNyGTJT05u0OZz67X4ljGOJqZZXSPvnTEobvAv6Unwbp9N2
	PnpCvbNDUJNphgHzz5dmekHS94tqQ0djiZ4HhA6cLXornbbYq5HFgw/9BJbF3rYXb1OxqwU7RuRxg
	Plhh3Y+3Tuz6QTMDXJbCY7FIymIV1KxF11LxiaVKfJo5lJqjR/TaiypI50rfXsAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qo3KV-0040mn-30;
	Wed, 04 Oct 2023 16:58:28 +0200
Message-ID: <3ba8e3902ade7483a82bd305a35a236744ffba25.camel@sipsolutions.net>
Subject: Re: [lvc-project] [PATCH] wifi: mac80211: fix buffer overflow in
 ieee80211_rx_get_bigtk()
From: Johannes Berg <johannes@sipsolutions.net>
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Date: Wed, 04 Oct 2023 16:58:26 +0200
In-Reply-To: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
References: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-04 at 17:37 +0300, Igor Artemiev wrote:
> If 'idx' is 0

And ... how exactly do you propose that is going to happen?

johannes

