Return-Path: <netdev+bounces-296177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hcBMbHoJGpPBgIAu9opvQ
	(envelope-from <netdev+bounces-296177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:42:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE0C64EC13
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:42:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fXfJnK6K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296177-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296177-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5DB230065FE
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 03:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF029343D64;
	Sun,  7 Jun 2026 03:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7404273D9F
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 03:42:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780803759; cv=none; b=kDSytRYPfgH/x1OIy9CTmJDJUBmj5Eiuly6kA3jHRZKOjyefRPsA1fDHnCyBK2wFxzZJDLxhZP9Jnf9mzCjJ45HBNzoyKcHj4UyrlOHCBpreEDZJwv4IWSbvocHFHLZj3K59AzFV6VgsJuZEiDWkealrDpbtfshwQa41Bpf81GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780803759; c=relaxed/simple;
	bh=dIn8bXh9x9eg9iVhLqs4HIRVAubFaG3c0ntTrvW6iJU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ce2hLgjQ8zhwHzJqP88TJ46O12qmJ3I+0YZh/qlIq0V86xSgQBgMb+r4ZXSE6oD+PcBIyKf8xKQwgt7phyLwsVhFrHEa67PmnIWCkpZjKQrpB8ovPeTk4yRxobcaB4T5Zs+6A9YfF7/q5THqca0Al8oKJHF978tqDVAUhATbheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXfJnK6K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4001F00898
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780803757;
	bh=x8o3/8jCQ9VRKpNIvck1fcPaDbxkGo9B6NhrbH6DkfY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fXfJnK6K9dw0mgOesYDYj6TQMapDnKjusVuDU6DRqjtA5Lb++RW7z6Yy+QNp5fXcy
	 cTb5KawsngxakcNY0hHMT+q3pPwKnpsiS9Vuahxx++2nEfPbIAiQuay3vEAWUnk46D
	 wg6n6SuZqwTQr6ZxYm3IqgNAXwAwIfXe2icCNxlTuqvCEXdtEmabJcw2HeIx+nNzUO
	 jFV9HpkWVj8C6TT1n5DRy9E9gEPxETqQluDMbY1LH3UOfFSNRRIxRb/LuFFcxex3eI
	 +DC3PGzdaZ5kom5pWfQO0z4K0pMO7ZkSQLuS+7Bz2m36osT9TnMA9HIlxOiZFF4E95
	 WuVGI2bbl2rkw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 982F7F40076;
	Sat,  6 Jun 2026 23:42:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 06 Jun 2026 23:42:36 -0400
X-ME-Sender: <xms:rOgkapcSUErC617sxOvFLuHmNYMZ3-MPPDiTPVIMMBe-1crMLzxeQA>
    <xme:rOgkaiBojoXgMF3nymh71O7q5OI0Ncn8PzCetdxujSykMpdtxBwEjnVTHnV0reOz4
    34hiUnwZEYOA4tcujKkGPYNAO0UGhwzv9Le49gn74cozHYzhXy8RzA>
X-ME-Proxy-Cause: dmFkZTEjLCyi0f09EjqfUTnxcYhoGz5el+BTFZNc8fsOta1VQQ3ggdAlAg2UwPoTa62KZx
    SXDJ0RWWeeqXG4XYOon+TKY8w3g00Ci4gj0cgKKk5fFRYOVMi2xs7/ud4McspppT5WMpUC
    TIjDIE0EEfE1XopsZweEuPV6TtaqwbfLgudU8xEe82LLcvgq3xJ8td1aVRiGDlOe8HaEe8
    ZRBPeRcDg4chlrt6cDNQc2J3Myx5B8Y4iqhCb6qdRBJ60920LgExWqLCvfJc+NhlzquE6n
    zCWdfu1YA56/fzpAiNBwpXB0h9mOPRNHm8WmtCaNIdIWc35Af+KOyLzlniBfc77TMmByfB
    bC+n7/ylLS4ni9Y0jyJJ37J2K2Nvx82E9uhwXUASOuoRGf4z1hpphvMR/jVdgfYT3sRCgg
    PAFmMLQN1Uu+YBs1m8G5mAkE43CU3y2yaFAwOoDplaNsGFC4elFhtJocfuOtMB+PcJ8rQH
    Ox2ysTC8xra9FVf/MyeRFlIbS4fnVS3TTkZBiVAPjzfREw7W1zNnvTwcL+xqnD23gNW5jW
    2HscGIVhHXByP3EIjzl7HR4H+Iy+XF0JAuuMt1e29oHkE0YHPO5nSckjGMvXxHwGKpcHoX
    j15j2lB3t2fs4y64onswOT9IifNddETN3I6yVmwV21CUKYEm6CqEnwhOKj1Q
X-ME-Proxy: <xmx:rOgkakrEPVL3qkYyJYHtGxvlTeh0qtMv3rRE1CGGBIIcNoaSv2LPjA>
    <xmx:rOgkagqH4Xu2CU7v50_ez2Gpa60hzvubBI1hYp2gikXuS2IEeFGcjw>
    <xmx:rOgkakDkURvDMyakdEbTOznurd67M7fHkkKpRmMHVfB_mN0UTGeEhg>
    <xmx:rOgkauu_YeLmWiRZfkmuyNhCe9tSRq1EybMWXisFn8IQICNU2sQSnw>
    <xmx:rOgkajKbKnaEYyrawHN2HNMpYKxaVp-jod4TUvKN7cE1y5POJLRngeYg>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E850780070; Sat,  6 Jun 2026 23:42:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACLaZbSY4szN
Date: Sat, 06 Jun 2026 23:42:16 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@suse.de>
Message-Id: <d0c7d57a-caa4-4cce-9420-e114e176433f@app.fastmail.com>
In-Reply-To: <20260604-tls-read-sock-v12-3-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
 <20260604-tls-read-sock-v12-3-b114efa6e3e2@oracle.com>
Subject: Re: [PATCH net-next v12 3/6] tls: Move decrypt-failure abort into
 tls_rx_one_record()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@suse.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296177-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid,queasysnail.net:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BE0C64EC13



On Thu, Jun 4, 2026, at 1:48 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Three receive paths -- recvmsg, read_sock, and splice_read --
> each follow tls_rx_one_record() with the same tls_err_abort()
> call. Consolidate the abort into tls_rx_one_record() so the
> decrypt-and-abort sequence lives in one place.
>
> A tls_check_pending_rekey() failure after successful
> decryption no longer triggers tls_err_abort(). That path
> fires only when skb_copy_bits() fails on a valid skb,
> which is not a realistic scenario.
>
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index fd8d3c979368..798f2535ddf7 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1827,6 +1827,9 @@ static int tls_check_pending_rekey(struct sock 
> *sk, struct tls_context *ctx,
>  	return 0;
>  }
> 
> +/* On decrypt failure the connection is aborted (sk_err set) before
> + * returning a negative errno.
> + */
>  static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  			     struct tls_decrypt_arg *darg)
>  {
> @@ -1838,8 +1841,10 @@ static int tls_rx_one_record(struct sock *sk, 
> struct msghdr *msg,
>  	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
>  	if (!err)
>  		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
> -	if (err < 0)
> +	if (err < 0) {
> +		tls_err_abort(sk, -EBADMSG);
>  		return err;
> +	}
> 
>  	rxm = strp_msg(darg->skb);
>  	rxm->offset += prot->prepend_size;
> @@ -2150,10 +2155,8 @@ int tls_sw_recvmsg(struct sock *sk,
>  			darg.async = false;
> 
>  		err = tls_rx_one_record(sk, msg, &darg);
> -		if (err < 0) {
> -			tls_err_abort(sk, -EBADMSG);
> +		if (err < 0)
>  			goto recv_end;
> -		}
> 
>  		async |= darg.async;
> 
> @@ -2312,10 +2315,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  
> loff_t *ppos,
>  		memset(&darg.inargs, 0, sizeof(darg.inargs));
> 
>  		err = tls_rx_one_record(sk, NULL, &darg);
> -		if (err < 0) {
> -			tls_err_abort(sk, -EBADMSG);
> +		if (err < 0)
>  			goto splice_read_end;
> -		}
> 
>  		tls_rx_rec_done(ctx);
>  		skb = darg.skb;
> @@ -2398,10 +2399,8 @@ int tls_sw_read_sock(struct sock *sk, 
> read_descriptor_t *desc,
>  			memset(&darg.inargs, 0, sizeof(darg.inargs));
> 
>  			err = tls_rx_one_record(sk, NULL, &darg);
> -			if (err < 0) {
> -				tls_err_abort(sk, -EBADMSG);
> +			if (err < 0)
>  				goto read_sock_end;
> -			}
> 
>  			released = tls_read_flush_backlog(sk, prot, INT_MAX,
>  							  0, decrypted,
>
> -- 
> 2.54.0

I reviewed the Sashiko findings for this patch.

Finding 1 is a false positive. The multi-step scenario described in the
finding (unrealistic skb_copy_bits failure -> no-abort -> retry ->
double-decrement underflow) requires a precondition the commit message
explicitly calls "not a realistic scenario."

Finding 2 is a pre-existing issue. The ZC fallback path lives entirely
in tls_decrypt_sw(), which this patch does not touch.


-- 
Chuck Lever

