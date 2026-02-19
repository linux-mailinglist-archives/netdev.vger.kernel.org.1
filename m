Return-Path: <netdev+bounces-259377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNQ4NhJYlmljeAIAu9opvQ
	(envelope-from <netdev+bounces-259377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:23:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414215B1E8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CF453018C06
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 00:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77921AE877;
	Thu, 19 Feb 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp3rdrM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B773EBF2E;
	Thu, 19 Feb 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460624; cv=none; b=kit41amuepYRhINAjwAOgh3h834Z8NV69hKMS3s0DD9cJNdYerzjBI8+Tz5jGyMcaImidi0Tqx+3xG4iUxX04OO+xt07+qi4ZMlCwFi2CMkYQNA6+iFoGK2ko86/9gHIGdi32gXWr8HsnWtw7eq9aZaO3Oaj2f82nDa8Lr09WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460624; c=relaxed/simple;
	bh=sXRU+201PAEQ9t8eCCb4yW5GPq0xGNFTgbd1XnJhi50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBSOgbl7pr6saGJGBlJ6Tc4eS9KszTltPcrMiSUyxJcrXKk0lOpbnV8+NzM5pZFv0fPx+Z7OfavH3hBb3kRT0fM1ukAqJoCZ3B+JvAPW8ip1YWBTfzgEvJSkKW3vayT/YtKqno0fkMRT/MUTAVNguodCfAv2vRAcR7686lHpvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp3rdrM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD82C116D0;
	Thu, 19 Feb 2026 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771460624;
	bh=sXRU+201PAEQ9t8eCCb4yW5GPq0xGNFTgbd1XnJhi50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sp3rdrM7hnvnet4AkcggfZopv4JioiEWEn10Mpr9uXEQ2TBpDolGGYzxZuaO9wUvj
	 fbXvPdOPjcGWoKBz4czbKymIcyzxsapSRPdfcN/OFdUmY6wtgitcSODdbtA+3cTQWx
	 2pvNKAQqAt6F9r+iJetl0wm8DS6BuD5FEZGpt1urV11f84P5t43C4D/gHelnzyMEZJ
	 qZyCtBvMcZRfWLnnD//uFbzD9nWybKT/gQKLdG9cKqoRrLpJpACYsnX/iMKOvuaKMv
	 n/A0apBc3qJXSxJ20DGmKjIea/n1n9PHmDKoR+OjR/gvb1saaLxDQvOSwyGv0Y0ENP
	 Kmx8xTY90xBTQ==
Date: Wed, 18 Feb 2026 16:23:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Cc: satishkh@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update usnic maintainer list
Message-ID: <20260218162343.0ab7b64e@kernel.org>
In-Reply-To: <20260218-usnic-maintainers-update-v1-1-dbbcd47e4656@cisco.com>
References: <20260218-usnic-maintainers-update-v1-1-dbbcd47e4656@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259377-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7414215B1E8
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 10:54:45 -0800 Satish Kharat via B4 Relay wrote:
>  CISCO VIC LOW LATENCY NIC DRIVER
> -M:	Christian Benvenuti <benve@cisco.com>
>  M:	Nelson Escobar <neescoba@cisco.com>
> +M:	Satish Kharat <satishkh@cisco.com>
> +M:	Norman Anderson <noanders@cisco.com>

Please read:
https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html

Specifically:

   The following characteristics of a person selected as a maintainer
   are clear red flags:
      - unknown to the community, never sent an email to the list before

The mailing list archives show zero hits for Norman Andreson.
R: / reviewer would be more acceptable if you must add them.
-- 
pw-bot: cr

