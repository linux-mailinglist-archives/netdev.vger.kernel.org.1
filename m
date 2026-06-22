Return-Path: <netdev+bounces-301030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id usOmBCkPOWqfmAcAu9opvQ
	(envelope-from <netdev+bounces-301030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69D6AEB80
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:32:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kWwpze/X";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301030-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301030-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39897300A522
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C38345745;
	Mon, 22 Jun 2026 10:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E2220F49
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124324; cv=none; b=rcYNCjR6otbPr0rtSPHAjtsBjAL+Gi6iN02zPUq7VIWA+fPBr8A4sp4OzSZ9XcIzgq9AbmChPzqaiZowMRe3VcrqE3nkGsGLVFoDb1Rrb6KzNP0eXyhDhwTiTxesujskIMqJ7t55w4JC035zcoUU2fV7cd7oGa8hOm7Vt8AcsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124324; c=relaxed/simple;
	bh=pq1K1O7TccNQxJnQ8Nso91YxjW0N8Vf4GxnYClXp/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgfZF4OF23WtY3ZmOe/RO8gvrHJHZguiEJjU8AxMjdXJ6HLtD17qmgPxxin45iaTMOThABNmyQo7tFCQAXMhRWEmih7noAAechSpbc+4Ndbz28zw2xsz4gwbJbHFZj10tYEvLwef5TBuoLn1+LtjSH3LygnxBxRm7ucHJrU/Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWwpze/X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422941F000E9;
	Mon, 22 Jun 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782124323;
	bh=o0SRWiMpacshWYzq/KKBsYhYEY49vcEVFbcZ2GI1sYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kWwpze/XQWnhKBgMzO30Cwh22U7ewEbMpxb4AVnZ08kAi7Mbd2Eejj2djeHy/SZDz
	 8e3Jx0LVe2I5FReK3yo/0EA/MaxI1x4Mm/SiHlWqPiNFnbyVi2j1a0/JrTJ1uVm5oX
	 U+OGS3qR3HNG7gkMsDUF8sgVo38Ze2UtkMtH9cRePOFvG9IANG5B45MutPBVv21y9i
	 QulAc6HOwsYGJ0b07bkM6xXv95pChrdMJOEVwMo2U6AClMwLUPp3R9e2Ik/IxO7NKp
	 rARel/pFfyjKn01DtiG6PdA32BqCa1RiBliQkob65qm2SjoH90h3H2q6GRT85+CskC
	 SK4uNfbAdk2/Q==
Date: Mon, 22 Jun 2026 11:31:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v6 0/4] Fix i40e/ice/iavf VF bonding after netdev
 lock changes
Message-ID: <20260622103159.GZ827683@horms.kernel.org>
References: <20260619061321.8554-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619061321.8554-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:jesse.brandeburg@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301030-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D69D6AEB80

On Fri, Jun 19, 2026 at 08:13:15AM +0200, Jose Ignacio Tornos Martinez wrote:
> This series fixes VF bonding failures introduced by commit ad7c7b2172c3
> ("net: hold netdev instance lock during sysfs operations").

...

Hi Jose,

Unfortunately the Netdev CI was unable to apply this series cleanly against net.
Would you be able to rebase and repost?

-- 
pw-bot: changes-requested



