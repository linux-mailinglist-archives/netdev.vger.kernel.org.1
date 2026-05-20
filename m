Return-Path: <netdev+bounces-289978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFEMNkHMDWqq3QUAu9opvQ
	(envelope-from <netdev+bounces-289978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:59:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36546590559
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE1F30B16AC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F482D0C7B;
	Wed, 20 May 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de6AbEQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4B3E8C75
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287816; cv=none; b=GeIKIWCL/eLEzhu/gvePZjEx881ri/3Kld4RxIChX2BuFrfmh5w++38a1o/wWPO17VmhRO0KdZ8wBOqmaqycr42PMJz64wFVkKnQNWgLxCOJS0hV7dGln79ou/F7FsFYBZrmAb2MWq2CBxTOt47Y6hWbwAXcNNJHDEt0KcDcUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287816; c=relaxed/simple;
	bh=UCPZ6oQwe4p8xEwkk76dzc674Pp9GMLB14c7FjGf7jw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aepRDnlHwIMT0Ob79aVRA7Cd7053mObaqYK2StAtmmFoQ0oYrrDaMZzBetlnXRhufa9Z2Hji5xjMIrlaJF6Seol9ghFg07lhj/F8Rm0FwdLYScMTGu76Wg/z42kO5DM4DKeUuX0znLUFytUUCJJJ4oqxvAlgz4A1IO76CQAq+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de6AbEQw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C3A1F000E9;
	Wed, 20 May 2026 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287815;
	bh=8wQkust8xqdL43oHilU3gO8aOxhTdHA1LLhjW7jjUFY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=de6AbEQwWdLjObqh0cSX0f0/5DbsoLaDe9rPUrPmPEthSL0EwOo27CmCeQSVhUkXv
	 T3Du9mbnr0ECiigjuNqBW6Bc/jA5v3TGoB+hQU3AFmKsjr8Vo+Y6sdAMO8NMA1KZGQ
	 fGaQ6MxYvC9mK5PiM+Qz7FDXE86v3kXsQnzJ8Cy13sQzo6Q7cMisrmRd00fSYSlk1/
	 jw1o5gC/vAVb0FKuzr0KFX69MCC/XwRIQQmld+1ivxMbbiSyWb+NzTyh7/ZePmpPPS
	 CyV43qu4Z6kTHaNuKUuaAn6EeYixr9i3Lj/srxwsaKyj//KKNOmO4X+1KrkpwwSWnA
	 YbaJcp2DK0Ajw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id ACABBF40073;
	Wed, 20 May 2026 10:36:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 20 May 2026 10:36:53 -0400
X-ME-Sender: <xms:BccNauz47zW2XS3p-5KrE8Xnzo_km_BqOwHUm8wSemlJdBWD3jcfOg>
    <xme:BccNalHY741MOwrMUR-F-1lhUxTAizp0DtJn5m-LY6mSvyVIgjH_wQ6QmqQuwpEpB
    JIwf6SxvFOXYD9mf-c8ASCL43gJpYBZDE8MMRUkGWdAWWhp327bUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhgrkhhukhhuih
    hpsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhomhgrphhufhgtkhhgmhhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohephihifhgrnhifuhgtshesghhmrghilhdrtghomhdprh
    gtphhtthhopeihuhgrnhhtrghntdelkeesghhmrghilhdrtghomhdprhgtphhtthhopegr
    nhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsghirhgusehliihurdgvughurdgtnh
X-ME-Proxy: <xmx:BccNasWfub7rJZWu96l0ijEAIWQrF8zKLn_G5ebv75gcqLVvYM9thQ>
    <xmx:BccNap9QlusNse0eWMPPNXwPxtFA9l2L5qCgtnyCMRONBCA2wIfYrQ>
    <xmx:BccNao5rAmDJZhLz8j1qnt2KFYFp9GSQ3GhcmN4xurj1Z4jf06eNvw>
    <xmx:BccNaq3dyZSsKiBvXREqO7QerX0wTNNWW8UIOuwCV_rNCNVVRGpdVg>
    <xmx:BccNanzWRfdZdaDA_Qt4FZL5RAaF5KkJ9IuBsygoeZg33y6Swje7rKWr>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8734C780070; Wed, 20 May 2026 10:36:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYfZjwqqI7hB
Date: Wed, 20 May 2026 10:36:33 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Ren Wei" <n05ec@lzu.edu.cn>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, rakukuip@gmail.com
Message-Id: <1aa329c3-d77a-410b-92d2-2cc03e737267@app.fastmail.com>
In-Reply-To: 
 <8c4cfe3656a817a64da9cf62e42282a1f308b9dd.1779253342.git.rakukuip@gmail.com>
References: <cover.1779253342.git.rakukuip@gmail.com>
 <8c4cfe3656a817a64da9cf62e42282a1f308b9dd.1779253342.git.rakukuip@gmail.com>
Subject: Re: [PATCH 1/1] sunrpc: clear rq_procinfo in svc_release_rqst to prevent
 double-free
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-289978-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36546590559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, May 20, 2026, at 4:13 AM, Ren Wei wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
>
> The svc_release_rqst() function unconditionally calls
> rqstp->rq_procinfo->pc_release. However, svc_process_common()
> does not clear rq_procinfo when a worker thread starts processing
> a new request.
>
> If a previous RPC selected a procedure with a non-idempotent
> release hook, and the subsequent RPC takes an early error path
> before a new rq_procinfo is installed (e.g., due to an oversized
> RPC fragment, bad auth, or unknown program), the stale release
> hook will run against reused state from the earlier RPC. This
> leads to a double-free or use-after-free vulnerability.
>
> Fix this by setting rqstp->rq_procinfo to NULL immediately after
> executing the release hook in svc_release_rqst(), ensuring that
> stale procedure hooks cannot be re-triggered on early errors.
>
> Fixes: d9adbb6e10bf ("sunrpc: delay pc_release callback until after the 
> reply is sent")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sunrpc/svc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index d8ccb8e4b5c2..0332f05e7061 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1572,8 +1572,10 @@ static void svc_release_rqst(struct svc_rqst *rqstp)
>  {
>  	const struct svc_procedure *procp = rqstp->rq_procinfo;
> 
> -	if (procp && procp->pc_release)
> +	if (procp && procp->pc_release) {
>  		procp->pc_release(rqstp);
> +		rqstp->rq_procinfo = NULL;
> +	}
>  }
> 
>  /**
> -- 
> 2.43.0

We should harden this fix a bit by extending it so that:

- svc_release_rqst() /always/ clears rq_procinfo after the
  optional pc_release() call, not only when pc_release exists.
- svc_process() clears rq_procinfo at request entry before
  early decode/drop paths.
- svc_process_bc() does the same before its early backchannel
  decode return.

That makes the lifecycle explicit: each request starts with no
selected proc, pg_init_request() installs one, svc_release_rqst()
consumes it. It guarantees that the error flows in svc_process()
won't encounter a non-NULL rq_procinfo pointer when there is
nothing to release.

Can you respin your patch with those changes?


-- 
Chuck Lever

