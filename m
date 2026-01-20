Return-Path: <netdev+bounces-251568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EMDDkrFb2mhMQAAu9opvQ
	(envelope-from <netdev+bounces-251568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B99492B4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1217D9ACE4C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDB3803D1;
	Tue, 20 Jan 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4sZBqKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F436D518;
	Tue, 20 Jan 2026 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929455; cv=none; b=TFZI5dvq5RqeRu/e+3TH87Lv2XYAHM6+A7o1WH3t28il67iauV0hS8EaHHbBjiH1gMRNwmIsH531Jsq9QiYANxOftGY25LgMsOKQTgsCNWkyM4c9iTmdbvuoyvKRwk2viV5xv2sX+qU4iN1hDsYoA4mL/fRfSY8T8z2lmvSZAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929455; c=relaxed/simple;
	bh=GC5leWFHxfCZZZb2UsLFXbBbyheKtE9khnzoBXJsTlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXlPJXhtoDvYPOUp1gGyhTlDS5OV3XLC9ZGos1SpfsS6PAy4mYADB3zK8UXu+/o1ayGHOD733UZhT3twsIxWWiuhhj0/kjCe+sQfPc2L+cDpiQuO1k6HyapS4iM7Zk2ig8L2CMoUj87IagVvh1EOtU9BxboQ8EhsVHIeD37UyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4sZBqKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0B1C16AAE;
	Tue, 20 Jan 2026 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768929455;
	bh=GC5leWFHxfCZZZb2UsLFXbBbyheKtE9khnzoBXJsTlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4sZBqKAJ/wp77ayWX8sZ4EaqUPJQJnufITzHJbYSFrpwU+rZqk24R+Ngqw5GScvt
	 Fq0UivAlevi/YgMQZCKh61uX8vlhzPUkYwj5QwZaUFYCRfUPoePVtzhQWJaZRNdZJn
	 beE8CaQvcuwtPquRz22GgFU8/VszyxPDAFMVc+vFsoTux/xAPNH4gGgwtev0nYPCab
	 r8/W8kLvpNC71FiAbzivZLMY6iDpR9FQYA1pQqMb6SZcbncmSOcIyyWB6YyF0toW1R
	 mN3HhwEzHzZSKE8FY3voUjXnOKv7cx80IROdMQSPbVNnOXE9zS2BOPIfSLu2VaVAUI
	 UF7P0I0f/++bQ==
Date: Tue, 20 Jan 2026 17:17:30 +0000
From: Simon Horman <horms@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
Message-ID: <aW-4qgp0mGNPNiau@horms.kernel.org>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
 <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251568-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,se.com,bootlin.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 83B99492B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 15, 2026 at 04:57:04PM +0100, Bastien Curutchet (Schneider Electric) wrote:
> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
> use the tail tag to convey timestamps to the host as KSZ9893 does. It
> uses the reserved fields in the PTP header instead.
> 
> Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
> There is no information in the tail tag to distinguish PTP packets from
> others so use the ptp_classify_raw() helper to find the PTP packets and
> extract the timestamp from their PTP headers.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

...

> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index 9170a0148cc43b4213ec4bd8e81d338589671f23..635679402f8a96b29536a91988346a8825bae976 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c
> @@ -16,6 +16,7 @@
>  #define KSZ9477_NAME "ksz9477"
>  #define KSZ9893_NAME "ksz9893"
>  #define LAN937X_NAME "lan937x"
> +#define KSZ8463_NAME "ksz8463"
>  
>  /* Typically only one byte is used for tail tag. */
>  #define KSZ_PTP_TAG_LEN			4
> @@ -383,6 +384,108 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
>  DSA_TAG_DRIVER(ksz9893_netdev_ops);
>  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
>  
> +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
> +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
> +
> +static void ksz8463_xmit_timestamp(struct dsa_port *dp, struct sk_buff *skb)
> +{
> +	struct ksz_tagger_private *priv;
> +	struct ptp_header *ptp_hdr;
> +	unsigned int ptp_type;
> +	u32 tstamp_raw = 0;
> +	s64 correction;
> +
> +	priv = ksz_tagger_private(dp->ds);
> +
> +	if (!test_bit(KSZ_HWTS_EN, &priv->state))
> +		return;
> +
> +	if (!KSZ_SKB_CB(skb)->update_correction)
> +		return;
> +
> +	ptp_type = KSZ_SKB_CB(skb)->ptp_type;
> +	ptp_hdr = ptp_parse_header(skb, ptp_type);
> +	if (!ptp_hdr)
> +		return;
> +
> +	correction = (s64)get_unaligned_be64(&ptp_hdr->correction);
> +
> +	if (correction < 0) {
> +		struct timespec64 ts;
> +
> +		ts = ns_to_timespec64(-correction >> 16);
> +		tstamp_raw = ((ts.tv_sec & 3) << 30) | ts.tv_nsec;
> +
> +		ptp_hdr->reserved2 = tstamp_raw;

I think that you need to assign a be32 rather than a u32 to reserved2.

Flagged by Sparse [1].

[1] This particular commit, from Al Viro's tree:
    https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
    To address this mess:
    https://lore.kernel.org/all/bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org/

> +	}
> +}

...

