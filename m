Return-Path: <netdev+bounces-299078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X3uDNUvYLWoklQQAu9opvQ
	(envelope-from <netdev+bounces-299078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829F67FE97
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=RXC4frVr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299078-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96723010159
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D4368D5A;
	Sat, 13 Jun 2026 22:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE432D7398
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:23:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389384; cv=fail; b=Ag9SGDNk6oSF0OPhMtLccCj2Ess3+ba6FLit9+SiX8FFM6pSoD9WvUSU+XgUb8zToHv4+y/Z8AqJXi/EhQkbfW41x+TwOdHV9QZzxsjrIyvGExsVmFfpHbadt0gkIcTQFW64RSu9m6cGG6CS2LHAN9K0DF7JHzHhGDFeag8mqps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389384; c=relaxed/simple;
	bh=7+UCwdV1ne49cq4fcMibRTQe+zHj7j8TUy7YJPYz0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQxargj6B15xaay+bXn2QnXcq108g2hdb8LwWBNYgp3DgYuG4aJqtXUYhsPWu7C6AiaGmTwRbPcpeG89V1WFkYfGICdy56pvLALDhtSTrij1cldurzCVwfTo0+SSPXT8qpKKkzArJaYeAD0aS7Dqr3HRzlXb6PkfpRKRuVMrpmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RXC4frVr; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DK7Lqo1544787
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jwd8bTapbEIKBMHRp+HoohnDcRxDUqI6nQwnmy5apkc=; b=RXC4frVrigul
	2+TPl69gny41YkeXpqOqbJD8TTbXSg8TLF3Mqa8gIyDAaPL1Ca9do2i2HlOHn+65
	CoxCrdgf9qWE8+7MbwigjUdDtdmp1AfYUyFCWoWend8LDbrYFB8tNlx+eS0wmY0e
	XBwyjB+KqTqOCrpMWoYa0NoDEtLtARehii4jUKwa9uklgqAWQAFaJ6LVMcE8YQM7
	alz+Qg7XmM00FAWye9ws7HX8pcHw0/UMPEsTvpByxH2Ie212YLkrrayKib69EdsZ
	UWVGo6QknIJteioPFD+o+4G2J5duEz4k2lDmocBu7Ml/04FaNl4K9dVPzKfy55Vh
	8w9vDSJ9BA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es26c2gvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6caac6486so2712857a34.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389381; cv=none;
        d=google.com; s=arc-20240605;
        b=bckSZa6fIz0kF4kJ3Q5fKQXE9lDl9UHy/DhCOTpDrQXSZRBeCBBGBnfIfvGs3KFQ3T
         1KfOTN+Nm496CLjD3XFA/rlMVRLJnkrewdVFVvuKDDJAIujFGxfNAATcuazzuWeae7FG
         CCrx+pg/8l7BaMae3YzvISJQAD4UXs+OUas3bPnQdSPVzjOHOccrc9/BJLvIP9mc4WiW
         y2pGQ6+CuG5avVfttnlj1XSNfUmjAlhMDSYewPzyzl+BEHbsA8fHlLkbOkHOWQ4CDBC/
         XS4W3w2YYiiQmPykOyfKGC6RbXL17HhUIYntM9FrGGSXOkV+fO3v/U+E6zXLK31Q2FgP
         sAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        fh=m53Kdjj75U/bnXXGsIGa/IUyNilDji4K0/u6zImfI0w=;
        b=ehMhGgvhQ/cFooe8LBsy7Yh4Z3+Q+cN6GQVPKyd+CL/pcodg8ec021Ac2pp5+pfE+U
         KM1+wniEpKDfaAA+Qmo2LC2uxg0nAmbMfX/zNcMkNqTfO+uvoIPekY8xYWSwz2JGti5+
         2vNg9hBlgrO3tLAJyLzC6YI4H+fbDi4emmAKZZH0kr78DXymc2PnowPC1nhiknDmo1Qe
         DyNBmpnsJD4Rr9foxQVKJYQtjStK4k8JoYEkDksvjvLtlW/8Wo8EAZawNTg34/mVz7k3
         n4VDuIUAVYM3tpisSO9MP564DsjBoCiehl1KDoZem2VCkHrbYj7QeCmmDw56lWccjJNc
         CFvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389381; x=1781994181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        b=R8qMTC0PhlReVbGO2MKUjUhbaJyPuGweJNFELYkGzgbsP7x8OIQVbFxIMckTON08jC
         5IaEbVbfqc4KReCsl3Wxr+Mtgevrx17/5V5huNd8YuYG9jry0ukT0ZAuWNL6gKbn1qx5
         O6XQ21v3HltUcFQ95nmYmJMdewHzKjn3oh6ZVWVW8aPbAMFC7sS6Ld2OlZVxYTUZ9DU9
         BgLuaxzXgDCV6KRxz3Vk3ttCMLuVQHM5c3djUC1UZbqujwuJbRljgmGR/XCSV9QO7nQH
         cNqV/Qkcfk3OrtiKzIq0tWv67Y92KXm8ZtxTCVQBmdqMn5HuUsqLLgTWOVRm5++V/CI0
         33aA==
X-Gm-Message-State: AOJu0YyM9F0jxk+LjUZiELEiw95UYn4JCDE4a67vPLXCXE0Fh1h94xvs
	fpGaZB1I4IEGP7iuU7Ew0ZNxZdvfF1d85y+0vW6p/0/qX9IxCVuSWvvbj7stg3/ph2RpacjQ8tg
	W78hCcu8ODhgNz86CqIquK6fpzATvvXyYlccLbazrgwolxlZxjMa3cDMnRg2mtCtDbz5N0Zw6NW
	qj/8b91Vjs3WWtzqYD8mlx/KEtZVceog2r6vqF5A4=
X-Gm-Gg: Acq92OHfMJtzdO555stYqagSS6PKOft0OTssDoL4VKBuf6stLeBXuH9uGs+FR+6wbg/
	zJvMnROetVDphpbM9PG2DOG9uvGhou014jUEViRCukfhSTK58aHuM0mggmhTRRGQo6deRkEtJrO
	4MVtCUi+1ucerTUy5I7FexSqJMzHrUJYsNWWlzeH68r23DyoVo+WCAWUYFbSdrj8LqjKFUVuU24
	rMg7N6JfV1YyUVU/N08DQ==
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7e7846b44b2mr6299910a34.8.1781389381577;
        Sat, 13 Jun 2026 15:23:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299886a34.8.1781389381161; Sat, 13 Jun 2026
 15:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-3-zhipingz@meta.com>
 <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260612105248.7d8431f2@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:22:49 -0700
X-Gm-Features: AVVi8CfDNU1g_5HOJkneMc79yczUqiaSKei6CEAn7F8ZvFdakbFhyfrfCnrLCmw
Message-ID: <CAH3zFs0+zF2JQMpVZMM9ndh+07KE1ULQNOkKrLozWq+_kRdMyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: X2-bG27FiLPoPXqslY-rNf75auSD1nDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfXxoQlH8MNIUj/
 vJeDx4KS6AVbvTBRJ7BB2WDn8OAOONoEuTx0NYVsBITErmSXpYFpWi1rd098JQOGBAbbBbG1UNc
 EwlO4ehHf6As2Ov9aQgJm+WA6jMU8SGbyLVlI7KNsMPguiyVQhsvkpr4DVOnlRHLk6m5EkTfiFS
 RhwWh0QBqoWvbvJxP0ymw5KWPDbqGyliAEy76S3GHiu7Z8I9gR9Rr4BsI8PNCApr7/1l8qwsk2d
 KCm/N4NdeBjBmwELTBn6+BW7lhrTgEVhdgfXf3JJFBBjV1TyHcTTxIrtQWX0eNE+YqtpgcYnwI2
 rQHMxz/ukIA2uk2zwvLk06QXvgC1Bih5csXMN19pDQA9udhzdRFlwgc2dT0ejfUIg3itunm5YbX
 2ToKnWkICMVn2+CkZoogyQufertQ3PWOuxEK1ccjp0Sm3gJBVIp/J5hdyWZM1z/m/aDqJfXWhqk
 Yl95z2tCiAIXYcLsFFA==
X-Proofpoint-ORIG-GUID: X2-bG27FiLPoPXqslY-rNf75auSD1nDy
X-Authority-Analysis: v=2.4 cv=QpVuG1yd c=1 sm=1 tr=0 ts=6a2dd846 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=JzgkHKIk_dV2mhMsj_sA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX39SDDq4/OA/g
 OQwzDIP51TqCbkIxSqWnklLbQgoSsW7iD0d2HlBciaoDElmFfMOfrcPAqrvoRdCAWqxLfouiH7b
 O8wJorAM824+kQbJc2iMIwAv5AfsbAI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:bhelgaas@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3829F67FE97

On Fri, Jun 12, 2026 at 9:53=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:17 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> > a device acting as a completer can gate on the "TPH Completer
> > Supported" field of Device Capabilities 2 (bits 13:12,
> > PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> > state. Fold the reserved 0b10 encoding into NONE so callers only see
> > the defined values.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> > callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This is carrying forward an ack for v6, where half the interface here
> was dropped and changed shape.  Thanks,
>
> Alex
>
Good catch, will drop in v8 and request from Bjorn on the new shape.

