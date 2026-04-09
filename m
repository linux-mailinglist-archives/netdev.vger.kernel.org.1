Return-Path: <netdev+bounces-277073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKDtNyLb12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:00:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0A3CDDD5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 858B7300852F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECA3E1D0F;
	Thu,  9 Apr 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exGcMpjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201303DD524;
	Thu,  9 Apr 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754008; cv=none; b=RfcQvGuoRK4JG/g5HYh6c99vOt14UHSFTmhPD2RGiE1krJc77FfXx4/L4oUSAgXkyPMxFrehKqzvUu/y6Ni2rg818lVg45UyLTjTZ0tvJXn0jSQqYMF2lVUJuXYbU7OxAX8safs8dy6msWQ28bvrtoXLQgy1vPIcW2i0BS2acNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754008; c=relaxed/simple;
	bh=xg5/gcPAXb0wx0wvcsoVaEomPZFaKAaea8EpgjD2fY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIv+Ngd1tP2K4oOooePKlMJ3QbY63nGQFqgcvodoj/hA93I4ZXV6syVI6ePlT86fQ591rUu7T4sbzRawhK+JTlTgavpqqLlHsSuX6wkIJDrcpV5KN6WNYH0HYWKgrxgkDnUL6RMuTWgzviYPiHRFuRV6mTp9xftCmyGu+uN0jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exGcMpjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46615C4CEF7;
	Thu,  9 Apr 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775754007;
	bh=xg5/gcPAXb0wx0wvcsoVaEomPZFaKAaea8EpgjD2fY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exGcMpjlJtaOYaDWLaVl4RhZFGnk6oPF2wSYh1jIwRiHyIgz46+wA6yj75C43Dcch
	 O2zSknC+FdMXTTSbCvD6gOwqtnqG2qp4y9ltkP+qLdbaicrVZYvz7nP4vgStrOQoNa
	 fqdObDzQ0+1a/RpoSm4HYm5ZOGD2hF/sjhkTz4lvw/JIUBrnsDeRgPR9mhbjdJeLz5
	 P3AY93h7DQhvkisbRpZqPDywzYwHyLJI3BsItDAN/kRVFx1eaNf9Wpj9J1ocgeK5Rc
	 6ZSV0TkNtbKsxEhsbt/XoX7K0G4sGa/YAmjaUeLKPNwNk4yXW3+raH2N47Wh10tQTG
	 Pi60wYaVLJ6lQ==
Date: Thu, 9 Apr 2026 18:00:03 +0100
From: Simon Horman <horms@kernel.org>
To: CaoRuichuang <create0818@163.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: vsock: avoid mktemp -u for Unix socket
 paths
Message-ID: <20260409170003.GQ469338@kernel.org>
References: <20260405195733.86043-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405195733.86043-1-create0818@163.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AA0A3CDDD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 03:57:33AM +0800, CaoRuichuang wrote:
> The namespace tests create temporary Unix socket paths with mktemp -u and
> then hand them to socat. That only prints an unused pathname and leaves
> a race before the socket is created.
>
> Create a private temporary directory with mktemp -d and place the Unix
> socket inside it instead. This keeps the path unique without relying on
> mktemp -u for filesystem socket names.
> 
> Signed-off-by: CaoRuichuang <create0818@163.com>

I think the subject could be improved a bit.
More along the lines of the problem being solved,
less on how it is achieved.

...

> @@ -845,7 +850,7 @@ test_ns_diff_global_vm_connect_to_global_host_ok() {
>  	if ! vm_start "${pidfile}" "${ns0}"; then
>  		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
>  		terminate_pids "${pids[@]}"
> -		rm -f "${unixfile}"
> +		rm -rf "${unixdir}"

rm -rf makes me feel queasy.
Can rmdir, and rm, ideally without the -f, be used instead?

		rm "$unixfile"
		rmdir "$unixdir"

>  		return "${KSFT_FAIL}"
>  	fi
>  

...

