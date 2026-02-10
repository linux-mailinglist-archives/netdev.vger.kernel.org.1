Return-Path: <netdev+bounces-258140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IrnAA/twi2mgUQAAu9opvQ
	(envelope-from <netdev+bounces-258140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:55:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CE11E244
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72EA3019D44
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F938A9D9;
	Tue, 10 Feb 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzesiNUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49D209F43;
	Tue, 10 Feb 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746096; cv=none; b=byyul841DBGE29Hmehz4jFAdwH7O8AaK2jF9/qQtdzkz/CdeBx1NChoEbDaaJYlYxuE8ACewZWf0JOh6vRBukyuyoc7ok9MuHE2Tx5bJWyRAP5amuwyapOJI5+5vj2wnBVTvTDJMcvdLwxa7jrTa22MqJP9oOR01WweKEU2RSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746096; c=relaxed/simple;
	bh=e1xJaT+uG0wdPiJkGC4RZFHoLPIzk8CspqV5GrifOBg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GJD/wTOKXGQOf+uBsSQafFsvrk1bEzPK7JbQ5RC5JwzdSwRKyoBC28arkOn1pKwzjCBkG3tGyQn+mCS9AMc9NsG8BDdUsl2jLB39zg9fO/S+g4ho6IEG0T1ctz8iscDEdIYwk6+SS+7Tec/NOesuhPyXL8w3bmnUl9L78w5qk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzesiNUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8003C116C6;
	Tue, 10 Feb 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746096;
	bh=e1xJaT+uG0wdPiJkGC4RZFHoLPIzk8CspqV5GrifOBg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AzesiNURdXz4fdLNWrZWBv/qi1bPZ19rLdpPtyGfK+0NTiTS2SVh4neJq90IYHipY
	 n63QcpbBDeJgeRNWUo7c7NHM0Uge43ZGQ1QuMJij21WInr+TbBi4w3YrvooOj6aclR
	 i3EVb7UXuJoGXPEkvcDxPj37qEPEyLeJuhGAOgjXNs10GK2S5zuEMcpzzC77OJFt2y
	 aQJoQCTOcRo+2ymCslPFE6naVRCWNVNhkG9yuxZ3Loldg5ViAZYhPoU67eUFszSqki
	 CgC4yO7+LcyEY0Rz+VAbMprRzlLkL5ydafzg9qYSEKFnndaRcgbBzuSv5htVn//Saa
	 zB1l4jw99ybbQ==
Content-Type: multipart/mixed; boundary="===============0694556948236941952=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fead0617797f86cced73d09a7ef91fbef62a5b47d3b37b5c7c3827e2a4478b81@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541@kernel.org>
Subject: Re: [PATCH bpf-next 3/5] net: ice: Add xmo_rx_checksum callback
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 17:54:55 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258140-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E2CE11E244
X-Rspamd-Action: no action

--===============0694556948236941952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c

[ ... ]

> @@ -168,16 +144,49 @@
>  	 * we are indicating we validated the inner checksum.
>  	 */
>  	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
> -		skb->csum_level = 1;
> +		*cksum_meta = 1;
>
> -	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	*ip_summed = XDP_CHECKSUM_UNNECESSARY;
>  	return;

For non-tunneled packets that reach this return, is cksum_meta left
uninitialized? The tunnel_type check only sets *cksum_meta = 1 for
tunneled packets, but there's no else clause setting it to 0.

The caller ice_rx_csum() declares cksum_meta without initialization:

> +static void
> +ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> +	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
> +{
> +	enum xdp_checksum ip_summed;
> +	u32 cksum_meta;
> +
> +	ice_get_rx_csum(rx_desc, ptype, ring, &ip_summed, &cksum_meta);
> +	switch (ip_summed) {
> +	case XDP_CHECKSUM_UNNECESSARY:
> +		skb->csum_level = cksum_meta;

When ip_summed is XDP_CHECKSUM_UNNECESSARY and the packet is not tunneled,
this assigns an uninitialized value to skb->csum_level.

The original code relied on skb fields being pre-initialized to 0, but now
the refactored ice_get_rx_csum() needs to explicitly set *cksum_meta = 0
for the non-tunneled CHECKSUM_UNNECESSARY case, similar to how
checksum_none does.

> +		break;
> +	case XDP_CHECKSUM_COMPLETE:
> +		skb->csum = cksum_meta;
> +		break;
> +	default:
> +		break;
> +	}
> +	skb->ip_summed = ip_summed;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The commit shows typical human characteristics including a subtle uninitialized variable bug and minor grammatical imperfections in the commit message, both of which are patterns AI tools tend to avoid.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Uninitialized variable causes skb->csum_level to receive garbage values for non-tunneled packets with valid checksums, potentially affecting network stack checksum handling.

--===============0694556948236941952==--

