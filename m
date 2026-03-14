Return-Path: <netdev+bounces-267764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLCHApCItWn11QAAu9opvQ
	(envelope-from <netdev+bounces-267764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:10:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857B828DD19
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE8C30151D6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4C310644;
	Sat, 14 Mar 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2KbxPS1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C02EA468;
	Sat, 14 Mar 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504650; cv=none; b=J4mcr4rqs5jSuOK/+yUYKBR8Rn+VEZni5YHXYceGzGUIho3DbhZnUjQWrMsPhu5yH25D0wLtNRX8fi6OgVVnBRB8ZskUBjKMQNdWKoYtn1CFbn7sTfNjfCAQ8mDD/uDM0RbiEoK+oJChNgE36eXYlDJwGm6ThAwbWMmPdvAuabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504650; c=relaxed/simple;
	bh=vUuiW6H+E9qWxWvj3TcDAxsvRhpeLxb2lGwQr6xrK4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dpgkx7eDlN+4cBRH6vdZxaDiVTbgC+672FJ7CbbLWvPScENHOQOMrLVotBOqmRgmueWEDvBWjBtFCjxsaZg/JMOZ9QDkjeQER3c9p096qGvdDBkgHSYax4tJOaTWLrgF5GeR8P6D/kdbqpq4uUV1cVboJtIV9uzN46vCPfNzO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2KbxPS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FB0C116C6;
	Sat, 14 Mar 2026 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504650;
	bh=vUuiW6H+E9qWxWvj3TcDAxsvRhpeLxb2lGwQr6xrK4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2KbxPS1Ekd46+EHoQQlk2mgAYc+tClo7K+acRUwZHVWkmy5dhgclXLqmpnlZh1fS
	 suiRlfnVM31XfZgMFTNgb9HVYcZ+k9iM9nRJzqpA7G9Hu+6PBHSy+osrNejUDLXoh9
	 B9LF8M6yAxNGr2w7KiLctuYNxlXQSK/R+Sys86uRNUF5BKAIIGQEwXS6G5cqlZQu8V
	 rz6xXMCPyfPY/5E+MXgfGwI00vOglAaeAYMM8DLOIZmi7KufBUbMvNmkxcgNd+s97N
	 LwHHkV3ShZq/Nr/4MmUhowATdX2s5bNciknVzVwKix0Pp1HoTo7IBzMkSFrCSjO74Y
	 pTXWHM7aVSkzQ==
Date: Sat, 14 Mar 2026 09:10:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] idpf: Replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <20260314091048.235a6d0b@kernel.org>
In-Reply-To: <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
References: <20260313150917.271086-1-marco.crivellari@suse.com>
	<0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 857B828DD19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 17:08:57 +0100 Przemek Kitszel wrote:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Process question - even tho you are also a maintainer I only read
Tony's tags as "please apply directly". LMK if that's right, I'll
try to remember / make a note..

