Return-Path: <netdev+bounces-274073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOZBBesKzWnhZgYAu9opvQ
	(envelope-from <netdev+bounces-274073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:09:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64837A2E9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24D9030224C9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E73D5672;
	Wed,  1 Apr 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="FBAezy0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43D3DCDA2;
	Wed,  1 Apr 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044794; cv=none; b=fdDFPzW1bv4x7ew/UxiXKN7rh1tpc9Zxf2YEcR90eBnW3tdmZwXDk1LAMBQl9kckDEMX7L881nBd+oNEuCb9usx4RBLydsgQDhqS7xakJr8+H5JvyZ4ABhHuGDfnRenTWFTsVZ8VpePT5uNWaQXBK7aRBnV7e8svilMedM5VdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044794; c=relaxed/simple;
	bh=yoddX4IZ4ec77cwOPa2F4+K1rvtdfnrzECWap8mVxMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6QuLta/uKweoa1fcS+3ylxA+xfxkZszTHd45EpmdQsaCcOs4TPY85q6f9N6UeLH1+6O/KVc3BlDg2BbZQwm0OM4A4xAY/C4Hg6M+hdRr5Adl2WoFV5SBZHspxfWNgrcBCnCb0r/Z0xlHQpY6ye5e97L0S/VuSvLkl1CPjexWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=FBAezy0i; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1775044789; x=1775303989;
	bh=yoddX4IZ4ec77cwOPa2F4+K1rvtdfnrzECWap8mVxMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FBAezy0i8n5XTo5BiP3WmhXMeoNEz01bghNaPIh+y0owMr9ZvJBMPKa41yhYcO1Yx
	 c1pCi4ZC8X44Oj4pK9WgvyTIMzGu//Dy8LWmEN+wECd1mNoDGx0nAySSni2z2rp3Uo
	 wpz3bOfhBzYNY6sZADMfIRAvA368LPt33mOPDZvki0/+3U2m0YhckdUlLW2KWwV2SJ
	 NRcpGx0hAb8DvVvEBHjP8FKw42pgRXde9lSLMrJgB6NrIFGHHlidIzdg98+35mEEQ0
	 o/ALJTecRgusj6UccrFGBRFFLHaMvRsYuhQJ5eMqd+ab4nmoLreEBK2WOjOVnv5iAr
	 o5e19RrkwN+PQ==
Date: Wed, 01 Apr 2026 11:59:46 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: Kangzheng Gu <xiaoguai0992@gmail.com>, gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, kees@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
Message-ID: <AA-_oeafacETaUw-zXqE2GL70EacawnSC7XXZnHEdy9N1gMfMr6X2N-8_ReZ35CpJl097iWNsCafQjaSiLLfhqttBeen2cUWRdRkomYEWG0=@1g4.org>
In-Reply-To: <20260331183358.3d6f9799@kernel.org>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com> <20260328185804.41325-1-xiaoguai0992@gmail.com> <20260330181541.5a3c9f73@kernel.org> <CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com> <20260331183358.3d6f9799@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e1f4d0d7beda9c064e2a86bf6a40840f82f327d3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F64837A2E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I noticed this patch
> https://patchwork.kernel.org/project/netdevbpf/patch/20260309173450.53802=
6-1-p@1g4.org/,
> but it seems that there is no further progress on it.

> Please experiment and return once you are sure.
> netdevsim (netdev simulator) driver supports net_shapers, so you can
> easily exercise this code in a VM.
>

Unfortunately in the case of shaper.c, netdevsim only implemented stubs=20
that return 0, so it's a not a 1:1 representation of the physical drivers.
The rollback path specifically is not reliably reachable with netdevsim,
whereas it looks like a proper trigger with real hardware.

