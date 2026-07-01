Return-Path: <netdev+bounces-303443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQEoJ6Z7RGphvgoAu9opvQ
	(envelope-from <netdev+bounces-303443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7A6E9411
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=V8d74ggy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B15E2300D78B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6F361651;
	Wed,  1 Jul 2026 02:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4DF27144B;
	Wed,  1 Jul 2026 02:29:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872991; cv=none; b=jhaLD8tBLAWlHiJAZiCY1aMxfxoc8H6jTIe5e4CpUKnjKXoDRwGppbB1im2AbEz+mxjGLvNlzZOMdg1+QMZBq/nKlswN6ryN+oS5cYRl3yObQvu1gGa+Ia0FwrNHmM5qe+BO8jpm+6iSiozJbZPNldVl/4PytelO5qCOIN/tldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872991; c=relaxed/simple;
	bh=NJkSlL75XIDiy2hfGGOtliYcxvA38oFZYUv23FHufac=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKfcl23L0zoHIVmodpi8EHUiOcCIuOFCDb2lxCFteudj49bcNSO11foLjnltOPNyYYak/XF3ZgNzOnwI2k2QApHEQK4Bv3yBaiDraJSTS400pFSDbLsyth0jTVZZWx33uEUuev656BSBvdWtekSieIQEI8JZqoWBtEShXqBCeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V8d74ggy; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNLfLU1795273;
	Tue, 30 Jun 2026 19:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=pd3LQo5n1jM4Mcv7nkl2/buzQ
	ZnB0rzE9KkpaSv2nRc=; b=V8d74ggyd+R+w9mvWawNZBhbupMw65AX6ad5av59R
	ATXzL0TsByKamJA74lBYfCE/jjN0QzEzhxlB5JQuO83itdcWkja2DCVOrEUFFSb9
	TVwPmyQY8iAXlsvvqCeGVveObJu01bS9mhVryb9MzxAwJ3YS8wxiCVfwAeWWdF4l
	nc4hIGddNTzxGtM4k7xbUGC5eWPhRNZTC5W3EPnLsdQIxcaCA6J723ckYezODbeF
	dWe7DW5z2DSGAB9zcXnfx6HvCA3bDM2v9sYISxGJFM3QZ4zBw8C94Xl6K/urSbaH
	rcFj3c5K5v4ERBY3wCtmVW952A/PGZs42NOqfuF284E3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f4cty37pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 19:29:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 30 Jun 2026 19:29:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 30 Jun 2026 19:29:27 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 554F03F706B;
	Tue, 30 Jun 2026 19:29:24 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:59:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jiri@resnulli.us>
Subject: Re: [PATCH iproute2-next v2 2/2] devlink: support u64-array values
 in devlink param show/set
Message-ID: <akR7g8aWfws3h2jx@rkannoth-OptiPlex-7090>
References: <20260630015012.3728870-1-rkannoth@marvell.com>
 <20260630015012.3728870-3-rkannoth@marvell.com>
 <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
X-Authority-Analysis: v=2.4 cv=etnvCIpX c=1 sm=1 tr=0 ts=6a447b88 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=g_DBIgpxiuV_V6QC3ggA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAyNCBTYWx0ZWRfXyQmWYrGZzMvr
 0iK8VlWFzjb4QJk4fq5/Qlik1OWzYidXhcnhdzhwcEs+FrnKKTEi6joxDwmagLiOo8z1BvaxMkw
 Nw6F4ka6fYHxKhOQ/kV3c2zBKzHalMc=
X-Proofpoint-GUID: eEfOPbK8Ze3mQ5g8OY8CESEBej82ex0e
X-Proofpoint-ORIG-GUID: eEfOPbK8Ze3mQ5g8OY8CESEBej82ex0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAyNCBTYWx0ZWRfX664aNGVuOzan
 kOmvnN+HrUy9cOLb/HY+5xJTTIam9IkiYuB5ziP9f5rMQ5ffSm1VsF247WcSpNDHA1ciBjw1Ug+
 BDzztRORkGARpKyhTCcp4BhncP6yD10N4TuM3Sn9+OP/v1z3PHsgO34NpFn6Sht3LDBRnEydK3m
 5SNl5m+VmBiyScUaDO8kkf8D2ACkZKr1Pagg7GZ8UpfVIaLXLnSqZ82i6ddm71Pu6XmA2WRZs41
 EcEaFrLdjVcCsJuYOoOcp04426e8u6xBs1RSQV+v2/HI5gFVstJaYU+fvnXe8vET0KMDJWr8rvY
 BdzghaQb5nIfCe060toISMDRsyz4ZxuBX48nYOE1mEUz6uOdH85EKyt0w9SbriUxJLrUZoQcwLX
 KXo5lkMx+S+ZoJhIlxqmICJejz442oO5jmUWPmj+VI4pIdG8A4ZM4XeKKKrQDA7cPxSiIBl6syY
 s1nzzBwqVeQRSYSib3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:dkim,marvell.com:from_mime,rkannoth-OptiPlex-7090:mid];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A7A6E9411

On 2026-06-30 at 20:06:17, David Ahern (dsahern@kernel.org) wrote:
> On 6/29/26 7:50 PM, Ratheesh Kannoth wrote:
> > diff --git a/devlink/devlink.c b/devlink/devlink.c
> > index 9372e92f..3c29601d 100644
> > --- a/devlink/devlink.c
> > +++ b/devlink/devlink.c
> > @@ -3496,13 +3496,115 @@ static const struct param_val_conv param_val_conv[] = {
> >  };
> >
> >  #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
> > +#define DEVLINK_PARAM_MAX_ARRAY_SIZE 32
>
> Why 32? Is that based on current code?
Yes, this aligns with the current kernel-side limits. See:
https://lore.kernel.org/all/20260609040453.711932-5-rkannoth@marvell.com/

>How does the kernel side handle
> the number of parameters? What happens if the kernel sends more than 32
> parameters - from a user's perspective, not this code and processing the
> output?
The kernel strictly validates and restricts the number of parameters. To be safe, this patch
adds an explicit bounds check to prevent userspace issues if that threshold is ever crossed.

Ideally, since "union devlink_param_value" is omitted from the UAPI, we have to define
DEVLINK_PARAM_MAX_ARRAY_SIZE here. Moving the underlying structures to the UAPI in the
future would allow us to share a single definition and avoid this hardcoded value in userspace.

>
> > +
> > +struct devlink_param_u64_array {
> > +	uint64_t size;
> > +	uint64_t val[DEVLINK_PARAM_MAX_ARRAY_SIZE];
> > +};
> > +
> > +
> > +static int param_value_u64_array_put_from_str(struct nlmsghdr *nlh,
> > +					      const char *param_value,
> > +					      const struct devlink_param_u64_array *cur)
> > +{
> > +	struct devlink_param_u64_array new_arr = {};
> > +	char *copy, *token, *saveptr = NULL;
> > +	char delim[] = " ,";
> > +	uint64_t val;
> > +	int err;
> > +
> > +	copy = strdup(param_value);
> > +	if (!copy)
> > +		return -ENOMEM;
> > +
> > +	token = strtok_r(copy, delim, &saveptr);
> > +	while (token) {
> > +		if (new_arr.size >= DEVLINK_PARAM_MAX_ARRAY_SIZE) {
> > +			free(copy);
> > +			pr_err("Too many array elements (max %d)\n",
> > +			       DEVLINK_PARAM_MAX_ARRAY_SIZE);
> > +			return -EINVAL;
> > +		}
> > +		err = get_u64((__u64 *)&val, token, 10);
> > +		if (err) {
> > +			free(copy);
> > +			pr_err("Value \"%s\" is not a number or not within range\n",
> > +			       token);
> > +			return err;
> > +		}
> > +		new_arr.val[new_arr.size++] = val;
> > +		token = strtok_r(NULL, delim, &saveptr);
> > +	}
> > +	free(copy);
> > +
> > +	if (cur && param_value_u64_array_equal(&new_arr, cur))
> > +		return 1;
> > +
> > +	for (uint64_t i = 0; i < new_arr.size; i++)
>
> put the declaration at the top of the function with the rest of them.
> global comment; fix all of them.
ACK.
>
> > +		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, new_arr.val[i]);
>
> Why can't this put be done in the loop above as the string is processed?
ACK.
>

