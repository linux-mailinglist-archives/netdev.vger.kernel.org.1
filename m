Return-Path: <netdev+bounces-142462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49D9BF437
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09923B230A2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8A206941;
	Wed,  6 Nov 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="q5rXAI1I"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91907206970
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913666; cv=none; b=B9V8kO7c80zOdY1rz2XgYH+53x9X8kfsAYLf1bptqIdsY6J3+ZHD2DMoRXpj4Dnsb9PJBK4YV2ZncurnALku9J52dWyTMLApiajiEV70wdVE8D8n+A4ZVOg+UK3CbiFx5GIx5wZHnHvClWZgcds2jvFq7y9qQFLhxcWU4Jl/uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913666; c=relaxed/simple;
	bh=decvzeerzkx1LhgxPluavMUNdn95U1jEx/c/Rh6JuGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jz62+Q/qo5sAEcDfdN93qt3hMeeXLCekhrAIwzKY9VG5kL3ALgjDpqhVFNQYyjfUOHjDxPQ2RBCylMWjBRGpALZ01r64DZYaYFwu9kE9mwKBLxv8TYBfee5NzfrTm2HaypjgMYHPyrQ/bFj36oIz6LWLB16LwZVE9cOxNDqzUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=q5rXAI1I; arc=none smtp.client-ip=17.57.155.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730913661; bh=decvzeerzkx1LhgxPluavMUNdn95U1jEx/c/Rh6JuGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 x-icloud-hme;
	b=q5rXAI1IrsAOVuxrIyGpGUgZwdQXBYGT67zX08lOvT1auz+XBOxcmhSLDO9Z9+BuR
	 iCvx59E87rHVfRljsrzwj7c/t+1B8pVknANe+j3MuSDRK1CnNr6YTSv3woBK1JeLbe
	 vsSuZ6Q/H3xjOcWMwUawSWxBRv2TY5VSWaJXrk/QarWixJCOck+53nKHf0k+/asNSP
	 1EwhgutL+WmWLhvZQmSSVi3NRcO6ADGbpUBFwRILEnD5/gXHu7RdBSIHko9Gs5atc5
	 tRemOnqZj2ZR2tlJTXo/xCfpxymW7zFFdQ1m6HrkQZhMivBZhQPb778e8cFqBmIBsX
	 YtE84iSLQVvxg==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id 766291980263;
	Wed,  6 Nov 2024 17:20:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:20:55 +0300
Message-Id: <D5F9OJYSMFXS.2HOGXNFVKTOLL@verdict.gg>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH] net: ipv4: Cache pmtu for all packet paths if multipath
 enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@idosch.org>
X-Mailer: aerc 0.18.2
References: <20241029152206.303004-1-deliran@verdict.gg>
 <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <ZyJo1561ADF_e2GO@shredder.mtl.com> <D5BTVREQGREW.3RSUZQK6LDN60@verdict.gg>
 <59b0acc7-196c-4ab8-9033-336136a47212@kernel.org>
In-Reply-To: <59b0acc7-196c-4ab8-9033-336136a47212@kernel.org>
X-Proofpoint-ORIG-GUID: NFSgMl2UztetJD27Ot8E9PX1Fiig1IJ9
X-Proofpoint-GUID: NFSgMl2UztetJD27Ot8E9PX1Fiig1IJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_05,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=419 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060085

On Tue Nov 5, 2024 at 6:52 AM MSK, David Ahern wrote:
> On 11/2/24 10:20 AM, Vladimir Vdovin wrote:
> >>
> >> Doesn't IPv6 suffer from a similar problem?
>
> I believe the answer is yes, but do not have time to find a reproducer
> right now.
>
> >=20
> > I am not very familiar with ipv6,
> > but I tried to reproduce same problem with my tests with same topology.
> >=20
> > ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30003 dport 44=
3
> > fc00:1001::2:2 via fc00:2::2 dev veth_A-R2 src fc00:1000::1:1 metric 10=
24 expires 495sec mtu 1500 pref medium
> >=20
> > ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30013 dport 44=
3
> > fc00:1001::2:2 via fc00:1::2 dev veth_A-R1 src fc00:1000::1:1 metric 10=
24 expires 484sec mtu 1500 pref medium
> >=20
> > It seems that there are no problems with ipv6. We have nhce entries for=
 both paths.
>
> Does rt6_cache_allowed_for_pmtu return true or false for this test?
It returns true.



