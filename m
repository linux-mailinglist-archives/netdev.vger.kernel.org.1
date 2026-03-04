Return-Path: <netdev+bounces-263564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GwcIQSep2n2igAAu9opvQ
	(envelope-from <netdev+bounces-263564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BB1FA0DF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C311830B3883
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE220351C1F;
	Wed,  4 Mar 2026 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPDFwxYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAA3502A0;
	Wed,  4 Mar 2026 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592543; cv=none; b=qKDba7UKyrsQ4DtAYVq85rXGosRzKUu3ftqf4acCO6ghq02KQsFloXmdxdqBRzBx9RdVl/if5Rb1s+XnpYs3eQ+pm8ySTHA9HL41N8PRI/nIGvOza0rskiptEXc5oCYk6xBNsQzsZBCDApx8taUVinY8HuFUfyx77JoQgFE+yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592543; c=relaxed/simple;
	bh=yed4GoPy0UTnDhtLDMT/CQakx0GtcO/iiACle8PR4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ibv7wKmHamRMuu1hKrWAoJDVOdqbHF+20k/OD67jkrlxWQtAsUq31glLBBQq026aRlwO/r5iHg+EzTsOWns5eoVRoOhYYOp7ZxqEpMqRtzT8yJLTKwcbq8dDl3IenzXljM0cCgaSEnl8Yq8pRIU01d0j0UMuYOR1ZLkRyZwmXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPDFwxYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E9DC116C6;
	Wed,  4 Mar 2026 02:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772592543;
	bh=yed4GoPy0UTnDhtLDMT/CQakx0GtcO/iiACle8PR4Wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BPDFwxYbpbg+yvckuXRHdTLP6CIaLFf3mA2IX3yvthdA1VfkiqMxXIMeBy1kCogAH
	 TycHfm9o1EiwwFJGqs7POBG5GzSKE4IVx+COEpWcXIn88zA8Zb/X5AS0hG62HO17Od
	 SSMDjqbL6Bkm+4nZyTO/+cBShoNVGdvCgNk0oY1vRm+Z7MnmAsiNES+3rMr+Eb4E6K
	 6RFdTs3JCHKuCoWgh3wTwrpQCIueUluNuetTL4YVz01ZQd/O3HrfwA6MZI9y8EhzaN
	 rLXOKwHETDnEF8WrY5sJkwxUF0TsZgMwGjcmV/6780Et8ST4MjFdg33pYg5JHOAVKl
	 YKy+XHTXCecmg==
Date: Tue, 3 Mar 2026 18:49:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Naveen A <mr.navi8680@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, shuah@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tc-testing: fix list_categories() crash on
 list type
Message-ID: <20260303184901.011fe650@kernel.org>
In-Reply-To: <CACQ1SaB0cnBgEAiX0iTM+WXL0cXYOsoi9wMUMvpcK-04hZLhAg@mail.gmail.com>
References: <20260228074735.10438-1-mr.navi8680@gmail.com>
	<20260303181700.25878b2a@kernel.org>
	<CACQ1SaB0cnBgEAiX0iTM+WXL0cXYOsoi9wMUMvpcK-04hZLhAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2D9BB1FA0DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263564-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdc_helper.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tdc.py:url]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 08:04:18 +0530 Naveen A wrote:
> > How did you find this issue? I can't figure out what's calling this
> > function in the first place.  
> 
> I encountered this while running the tc-testing selftests locally.

Running locally meaning? via tdc.py ? Or some other way ?

$ git grep list_categories
tools/testing/selftests/tc-testing/tdc_helper.py:def list_categories(testlist):

I guess I don't understand what the purpose if tdc_helper.py is
but the function you're polishing appears not to be called today..

