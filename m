Return-Path: <netdev+bounces-282049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKu4Ndn88GnubgEAu9opvQ
	(envelope-from <netdev+bounces-282049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7060F48AA84
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E19300E3C1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAD47AF6E;
	Tue, 28 Apr 2026 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ6EVaz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36A47AF57
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401034; cv=none; b=f2vhiUWe+yWCnHzpqTEeFJTNw2w/cC3ST4fYw7jQrPjXVR6QRFs9dppBwMjL6lGRVHbhTEWSN9BBl4EmVc025EDOmZvKevJdr1chErr8M7jJD6k35E0UTjLgTbvYIPzpjwMaOPNO+2HmAY//sbw/rQY8dpwRBi14z5K8AtYSdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401034; c=relaxed/simple;
	bh=Wu1rPi/JdV1ncJyIF4Ch7km429IcExTfSCrhEs8W8Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcptru7480KnFzYQGWO7Elz7xzV3cElCp0ixdOKT+G5RPSJxVm2eN/bQE7/4jEGyIlzuU11B/Fo8E+GwqwmibNQ8cdp1Tv5QMBdWCBHWInpH1JyQnc1RLVSmxUgaSdntAivYaU+GdceN129KsGQbVfpZ2YM9EM4zkajYUftXM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ6EVaz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD311C2BCAF;
	Tue, 28 Apr 2026 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777401033;
	bh=Wu1rPi/JdV1ncJyIF4Ch7km429IcExTfSCrhEs8W8Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ6EVaz3yviM37KAMMTNpZicruYnfKUMHrJj8SvzFlDOnUNiKRML/TxszMZo3DSM2
	 F5XBC7oJOdIPdAIyPzz6W/sUbfolUoVhw7b8pcheYc1a0MuO4IG90vPYRL+md6oNei
	 l4hmoneb4L6LFLE8kbXU91VUsxnqSjnnnJP0z1Em/phrzzmaUgJAMBQ/lCJWPsGrW8
	 dhJwXBoLsV/NLYyQBcFJXizp32OOairjonwzEClmSSEMxpCcWQqK5z+xSNkDU1/JqA
	 pWLizWs9VTjXrbCS/rUunuG9OMCXbr6KiZLQ9YXAuLxevEwAdiDALqaKkOrGPOTEA4
	 sDiq4zQ7owNIg==
Date: Tue, 28 Apr 2026 19:30:28 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	marek.lindner@mailbox.org, sw@simonwunderlich.de,
	antonio@mandelbit.com, sven@narfation.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, tr0jan@lzu.edu.cn, wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions
 during teardown
Message-ID: <20260428183028.GW900403@horms.kernel.org>
References: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
X-Rspamd-Queue-Id: 7060F48AA84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-282049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

On Mon, Apr 27, 2026 at 02:43:33PM +0800, Ren Wei wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> Prevent tp_meter from starting new sender or receiver sessions after
> mesh_state has left BATADV_MESH_ACTIVE.
> 
> Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - Split the original fix into setup-side and teardown-side patches

Hi Ren,

An AI generated review of this patch-set is available on sashiko.dev.
Could you take a look over that. I expect that some follow-up patches
are warranted.

