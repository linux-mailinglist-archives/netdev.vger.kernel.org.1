Return-Path: <netdev+bounces-255130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I0aCEamfGnCOAIAu9opvQ
	(envelope-from <netdev+bounces-255130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:38:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339FBA95C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303563007E0E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6C37BE70;
	Fri, 30 Jan 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+KOIyFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7A23EAA1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776587; cv=none; b=lDWU6zfDURmQgGatOcI+nYaWIf9sVr4F6CQf9Ln3hl659cXmQXafq5/C9UahNMtYN7qegVJOpHVTAUkD6+fc62fSmUGgWXsj60/FRWP6saWD6KOnYW1iGb5OekXa12EzEADa9ek2rNB7k3cBzpdiVl9ceqSr/ijsRp6kGKKF6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776587; c=relaxed/simple;
	bh=KrxdH3mljOFP58fCHOBTh/G31XI1FXKq/4/o+xP6G7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqoMGbwpwBJGAUSdQ40/jFNPlMcTclS837ScgoH2FmZkZMFqADWLsFILk2lhOWUj/96xLoJtrkA/hDbCLnvbsEEd1UfHF0DOs8uysNh6wdJVq0tIAgOQ4YDvzkfRDGeP9PRJzp6ILqDdkXWgsHnNSzqOjmOXE5nXzOCGrCIVQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+KOIyFK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so14598315ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769776586; x=1770381386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnO32hbWXvDgVb2EF8+0dkq47eMPxIFNlb7lppJN2vY=;
        b=A+KOIyFK9CgcXPZoL6zLsNZnLrdpgLjs+JJvCeiQS9IjWFXma9n07VkGXj1QaxiAL8
         rUViemxrvt7fNkYwCrooVuGJet5SQS7/hXiD+ygF9bEFFV5B0XrvPvn8IM1rhEwtk+Hw
         o6ea2XQCXH0QdPVF7RBHTq3h8W10OMVVgoOnamkxfQoW3+71r2DkQEgbNf42vMP+LJbA
         AJAe337r6WH3gVM7UV4rcnxYAFSdbm+J0weAWCa2d5ehX632fUsY/0fQ79XeKiHgUcfT
         W2SYgdRKF6fG8Gr8JPNHMEtSXJWBd00aYSL/rKCjpqsTcae7snfbgtxGGEYuqbZQ5VTy
         O6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776586; x=1770381386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnO32hbWXvDgVb2EF8+0dkq47eMPxIFNlb7lppJN2vY=;
        b=dDbT+TibQNyVkTDAgSxBPx5ITNsPKScxGuo4IOrI7zF19/XasoBxLyGfhHUN+4OLsk
         GrU/WmNjShpAFho9uu2qZ1SnQ4Klu4+V61qeS0aicGjrfEt7raxYem/5BvpfvWdoV3np
         TPLJIFjjdy8de1gotQcR590CHjPoT2sF85OBHGH7DGrA1YEckTcZqmojgqLZElvYRmMj
         g9IThHAA9jv2JaCsSX8P0PpzBEvZMUuLUxEcAaQO5XYP8oCo4GdkBGK/z9KuidJO1m8Z
         l1Bu000nJ6pPCIF22blJNZJFqQPGt72Ohh75WSity8bFo5X8P9xtNz4tVMonL6cxCkyB
         aGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEMn5uf5fuJ1DL9rqi/BIsR+tZNhxnrE65oJ14FqhgBXcS1HGkJ51TewYF7OBrtsWYN/F5JJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSjoqCkagsz3BOzKOdIsZswOPT4AyP0jWPigf18Q319+4T77M
	kWUYgYx0ui9JFXYknXZiNlOvzPyJaROYeq89L77DECaXJFc4Ma7P8aGN
X-Gm-Gg: AZuq6aIhengaVi5Wic+FcAxoRJviR83W1CTAMVis+k757hmUIBVmpUFbh8vaBLokYDO
	p0BO4LE4Ju8zTW9Lf/qgLRORVWPoiZWRr+3NH0rRFbZvECFxxoHfyf+TlxvE7khPlcJ2nt4gKQd
	tUfA68OLTQrBk3SJheTz1gP3hHe5XJC6vP6DxM6CyLFaFq74+seWItb20KomrIM6duCQ3CtWy4M
	8vSHYjKltrfH+M/CsVl4qpR0S7mfacYe8kaoV8taRu37dLmSODkpcbRInulHhMqCQR7baMYmEUH
	dN6j6DhrpomcgaJUJRPVhaFTAb0mB41kiAOoMEy3waHRUPEDozjAWG+N2MZj5xrctSMGVRot2E+
	CVEUYXsUJsTFur6Y7qC8A+X2BSGFcH+RZA8+Ux3G1lqgD6DMTDSDbaGAUeyVur8uj2hahaIddvX
	kI0ZhTFApdpsIDxyykk0AyVgKWqg==
X-Received: by 2002:a17:903:1967:b0:2a2:acc7:f1ee with SMTP id d9443c01a7336-2a8d96b15bcmr32237805ad.21.1769776585751;
        Fri, 30 Jan 2026 04:36:25 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b426e3csm81275885ad.44.2026.01.30.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:36:25 -0800 (PST)
Date: Fri, 30 Jan 2026 12:36:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if
 getting speed failed
Message-ID: <aXylwyr2pV0rZAW3@fedora>
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130111904.144024-1-tbogendoerfer@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255130-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7339FBA95C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote:
> bond_update_speed_duplex() first set speed/duplex to unknown and
> then asks slave driver for current speed/duplex. Since getting
> speed/duplex might take longer there is a race, where this false state
> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:

The patch looks good to me. But based on your description, I don't think
the fixes tag is correct.

Thanks
Hangbin
>  update port speed when getting bond speed") this race gets more visible,
> if user space is calling ethtool on a regular base.
> 
> Fix this by only setting speed/duplex to unknown, if link speed is
> really unknown/unusable.
> 
> Fixes: 691b2bf14946 ("bonding: update port speed when getting bond speed")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/bonding/bond_main.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e7caf400a59c..4cdf89b21ca0 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave *slave)
>  	struct ethtool_link_ksettings ecmd;
>  	int res;
>  
> -	slave->speed = SPEED_UNKNOWN;
> -	slave->duplex = DUPLEX_UNKNOWN;
> -
>  	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
>  	if (res < 0)
> -		return 1;
> +		goto speed_duplex_unknown;
>  	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
> -		return 1;
> +		goto speed_duplex_unknown;
>  	switch (ecmd.base.duplex) {
>  	case DUPLEX_FULL:
>  	case DUPLEX_HALF:
>  		break;
>  	default:
> -		return 1;
> +		goto speed_duplex_unknown;
>  	}
>  
>  	slave->speed = ecmd.base.speed;
>  	slave->duplex = ecmd.base.duplex;
>  
>  	return 0;
> +
> +speed_duplex_unknown:
> +	slave->speed = SPEED_UNKNOWN;
> +	slave->duplex = DUPLEX_UNKNOWN;
> +
> +	return 1;
>  }
>  
>  const char *bond_slave_link_status(s8 link)
> -- 
> 2.43.0
> 

