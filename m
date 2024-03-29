Return-Path: <netdev+bounces-83143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB79891075
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8442B1F22F5A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC617BDA;
	Fri, 29 Mar 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knu8+epI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BC179B7
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676326; cv=none; b=QX3zmHuunTA+k21hgCrfDYG7h8X3gW/myJuVBRqSMlbGVO75aEFPZfqGOlW2NDvLJTgNAfhGQ9GSrcLj+VWnxjHLGjT4k6h49ubHAmZULj6+V6nvWgwz4jJqLVZ2a6XdhB40UUvPE9VSkxH6lewaXhvXEoYV9JaqcEwhhWkDyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676326; c=relaxed/simple;
	bh=j3K0wz4EabblYV9XiBykUIfUzK2axo1ap47yKSK157k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXyA1J4YlDVYltx5kLFjEMW3ALQKmtCWNw6RnKlyVbpOzcQjkqhLSwU91IxZMbiQD4nNjp1di9YGFpZbym9usSfy1CmTeA77BLL1UoFANVduQMW+2G5o4BYTTaI4qNDG1s9xuSpn5rxXFiEEWXD5ZIH5npHFLYtKW2ZiKvk9yHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knu8+epI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4AAC43394;
	Fri, 29 Mar 2024 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711676326;
	bh=j3K0wz4EabblYV9XiBykUIfUzK2axo1ap47yKSK157k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Knu8+epI6K5pHIasqQNsgo6O0six66UisnAnd6285wFgnd39KkDVoxGQS3EYRXGb2
	 HJ9014hMzIB2u8rr2n6on+3SRu4ZiZ/3TVA/HhoAw8mxU2oR7cwRWh0YY/kV82JvMA
	 n9yVvKDOPB0J2yY7VFyEC/13K0dwO2mAF2ob9v9/AxdkFigxrgrs8oSlxe8UyvcaNi
	 hkh85iy2aLgEzbL594Ku9FT6xI7nfwmFPbuR/m2bxrn+i7AULxKdJxlI3vRqSDSqh/
	 jtJBW94MVAyKDBzZGMZa2Y18N5ulSoDteJKy79G64U3pvWJIL/fYwciWsI2l1RfNT3
	 DoZ9/E/wh202A==
Date: Thu, 28 Mar 2024 18:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Breno Leitao <leitao@debian.org>, Alessandro Marcolini
 <alessandromarcolini99@gmail.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to
 generated Netlink docs
Message-ID: <20240328183844.00025fa2@kernel.org>
In-Reply-To: <20240326201311.13089-3-donald.hunter@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
	<20240326201311.13089-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 20:13:10 +0000 Donald Hunter wrote:
>      return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
>  
> +def rst_ref(prefix: str, name: str) -> str:

I think python coding guidelines call for 2 empty lines between
functions? There's another place where this is violated in the patch.

FWIW I also feel like the using the global directly is a bit too hacky.
Dunno how much work it'd be to pass it in, but if it's a lot let's at
least define it at the start of the file and always have "global family"
before the use?
-- 
pw-bot: cr

