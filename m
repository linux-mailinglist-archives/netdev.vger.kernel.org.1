Return-Path: <netdev+bounces-277947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGFGMrln3GnoQQkAu9opvQ
	(envelope-from <netdev+bounces-277947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1C3E704A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E2553001F92
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6F37BE91;
	Mon, 13 Apr 2026 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FTLplFtx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE31624C0;
	Mon, 13 Apr 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052147; cv=none; b=E9HSWL62NVk+6H5hPZkGg2Me+hYfUvXRD0r7usE8iBypE8QC+XY/TmWsn6UJWhC92o0uKapLsIDF7cPy0/3V9NXyiETbI3RWLnhgJVT2ml3OlTzR8oR027pm9UASdb6BZf6Fk1C4GhFhaR4lZiADHWzGKQePr3sSq9/WO80AKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052147; c=relaxed/simple;
	bh=7XT8jQFKhQPi6m0BiSj2fNHbaAA4HfCB1b0sOPbEhec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZk7gv+LnojvgtIIxHmhtEbMDW3xXfLmRzb75UIcluM71/Br/9Kmmf73xCH4g5pQogqq/MsDZM+mjUTUuVA9oIG1hyO87J/v5a5KJMwWHa0DMlHHdWudfX75/eiYCudhLUVOfSbip5r57xKtQVHlWTrbj/3Bw2vjjIIkW2Y5gFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FTLplFtx; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CM2Dr61857891;
	Mon, 13 Apr 2026 03:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=1etFCmvme2baTl/EdL6GLOxJBBQ3MX5tKscevVXvyRk=; b=FTLp
	lFtxE3JkDHzCFfpYarozVq+UTgG5PrlbX4NpRE5bi+yQqXNyOIQ7TooclJupAdOI
	d5BDCYQaG6LtMqgOGLLmo2e0neniwCSrIMaQO5MPKcue47kPN7VXAb8IKD8CZpj0
	CsgSPpHxqyaITnA9wXor4lxxPrNpSWTIRumI557jmEKUS/+whXyNdS4zdvvAJA+1
	PkFtQAF8flnO1I/cC3mpjL6vNa0FT3cNsWMUWHgaHImI+UN+6c/5cgMpvP3LgtRI
	3nWgpxze6403YqHQYF+WUU9FVoavzdKYEeMS3gC4tLu1jOivid500sMM1ffwCTQH
	ooT1u+qZQtATUQkCbA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dg1hxuqeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 03:48:37 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 13 Apr 2026 03:48:32 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <ameryhung@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
        <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <clm@meta.com>,
        <daniel@iogearbox.net>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
        <kernel-team@meta.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
        <netdev@vger.kernel.org>, <yonghong.song@linux.dev>,
        <linux-open-source@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in local storage
Date: Mon, 13 Apr 2026 13:48:29 +1000
Message-ID: <20260413034829.39307-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
References: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: eD2s3wDOa7Cz--sW2bSM6QJARp09QVqG
X-Proofpoint-GUID: eD2s3wDOa7Cz--sW2bSM6QJARp09QVqG
X-Authority-Analysis: v=2.4 cv=Z67c2nRA c=1 sm=1 tr=0 ts=69dc6795 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=h-wXxoor8ZUhGJ0R1u8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDAzMSBTYWx0ZWRfXxSFkYLXQs2xs
 v/+x1vE02VN6PVXLi2sMenV29uxFoV37GXfwycaUI4XLaVuolLUDo3xz6JIeT9IKmqfgbXDpHle
 OoPYtRO+PzaeLLc2+wucUq3Sk/tB57VtNdlhnEtfJj76P1/PEL1H9WJi8Qodp+JFGvfTJlygsZh
 227eqy5L/mnWInVAy9S5SXhtxufjPuAaJaOS9HlyhFPKc3yfvwGe3xDGErmmLeZNQNklBEK24Kg
 JrY7Z1IyCmezhiAZlwwBMQT0RbO63Oe/HVzY2l8h2lxmmlO4XW2CF8au2t76/e73V1UHhoWn2yX
 8yNVyLHpUn+WK2oCQF8/at7XkjvbR3Yr7o0POUHX8mpN6D28VVANKbEexhl6QJ/njzTlnBNyfO2
 fS712Vlx1wFk0qokxAMlyDI7gCR1uKfP7vfOahedyED8KRYK0yIyHKtOT+7P7ideHwo2BXYnHIA
 BY8ztE/H+isd7rlL0kw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11757
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130031
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,meta.com,iogearbox.net,linux.dev,crowdstrike.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-277947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava.imameev@crowdstrike.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEE1C3E704A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:39:00 -0700 Alexei Starovoitov wrote:
> >
> >
> > This allows value sizes up to ~65KB. Before this patch, socket and
> > inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> > which could handle those large sizes. After this patch, any
> > elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> > creation succeeds via bpf_local_storage_map_alloc_check() but every
> > element allocation returns NULL.
> >
> > Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> > KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> > storage types go through kmalloc_nolock()?
> >
> > Slava Imameev raised the same concern for task storage in
> > https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/
> 
> Right. Let's update it, but I don't think it's a regression.
> On a loaded system kmalloc_large() rarely succeeds for order 2+.
> That's why kmalloc_nolock() doesn't attempt to bridge that gap.
> One or two contiguous physical pages is the best one can expect.
> In early bpf days we picked KMALLOC_MAX_SIZE assuming that
> it's a realistic max for kmalloc().
> It turned out to be wishful thinking.
> kmalloc_large concept should really be removed.
> It deceives users into thinking that it's usable.

In defense of supporting 8KB-64KB allocations for local
storage, we can consider BPF_MAP_TYPE_HASH with BPF_F_NO_PREALLOC
as providing similar functionality to replace the missing 8KB-64KB
local storage allocation support. However, these map entry
allocations can also fail with similar probability since they
depend on the same underlying allocator.


