Return-Path: <netdev+bounces-145103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBA9C967E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A9D283A1C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9B1B3942;
	Thu, 14 Nov 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=castellotti.net header.i=@castellotti.net header.b="ccDvCUP0"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A51B3937
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628640; cv=none; b=RnIB2uOmYhof89BMCRaC2vqn05JRtHjO1Pt47IP2eQYO6g3kKjEI0wQ17p37n6DnDxwIaZ2hG2sfRtb43DfT9OkWasOk9Q5fYMckkW6c1pvSv63FbeIooq/86Tf+9BpdCsCradVO40w/Aw935ZAOKrem9ItYhXcAfFwsMCGQOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628640; c=relaxed/simple;
	bh=4lFOEw1Cuwl0/qLgmCJe5RhGno98lXHPUYNOJ0IfpX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IH74EVkMyId1EWh4Vkj7ad7UW0eOnM5hO9TQXvDvmfiXoKS3AvHH3RX7D39pS5KKzF9ZMQqHprUvP71bu3JStpaTBRFXxs5kfHtHq5RrLPU+WbFejn6rH+XK+Y83jK4AtXAyj75s/6UOzO1H6rImdh/xcjcmn/+RGbBwSSM/XAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=castellotti.net; spf=pass smtp.mailfrom=castellotti.net; dkim=pass (2048-bit key) header.d=castellotti.net header.i=@castellotti.net header.b=ccDvCUP0; arc=none smtp.client-ip=17.57.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=castellotti.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=castellotti.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=castellotti.net;
	s=sig1; t=1731628636;
	bh=iSCE/Qi+tv7NDRxH+x0UHfkFAYCL1dJiR18XFW4tY80=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version:
	 x-icloud-hme;
	b=ccDvCUP0SWQJCXe6CnHMGpX9Lipo3GhPS/7nfjEkeW8sLC2vvSeQ5zoA/pdiFGrBd
	 MzX626s6TvubZk5CHJjE1slrOlDMa0Cm5aQ3QuXZ2JdPzuhX4W06Rh1Tx8JYcBKJht
	 zFzKlZX8mMytx8ZlZHfcj9EzyYXF3uAoEuEbj7JHGO6VjtY4HBDUhAprjJmpYef/Lr
	 xeoljcOU3SXxUEwBupEsM6BVHasVzamEoqinhYEaGs02rznrsh69NdAA9EmubHlDGb
	 xFefMwOG6UOmCE/zzMsq+813l1Vtn3wZorBtB3PoJV8uWQS63SV/K8SveLxEV2suwz
	 z8TWWL4QFpSxA==
Received: from MSI-Laptop.local (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id 99FDD25401B4;
	Thu, 14 Nov 2024 23:57:12 +0000 (UTC)
Message-ID: <799753305484d74cb9d194347743ff986da071d5.camel@castellotti.net>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: Correct BASE-BX10
 compliance code
From: Erny <ernesto@castellotti.net>
Reply-To: 20241114195047.533083-2-tore@amundsen.org
To: Tore Amundsen <tore@amundsen.org>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, ernesto@castellotti.net,
 intel-wired-lan@lists.osuosl.org, 	kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 	pabeni@redhat.com,
 pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com
Date: Fri, 15 Nov 2024 00:57:10 +0100
In-Reply-To: <20241114195047.533083-2-tore@amundsen.org>
References: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
	 <20241114195047.533083-1-tore@amundsen.org>
	 <20241114195047.533083-2-tore@amundsen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: Spi5FdVucACLcYERu8XdpffBqfSFfqS6
X-Proofpoint-ORIG-GUID: Spi5FdVucACLcYERu8XdpffBqfSFfqS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=876 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1030
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411140190

On Thu, 2024-11-14 at 19:50 +0000, Tore Amundsen wrote:
> The current value in the source code is 0x64, which appears to be a
> mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
> incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.
> ---
> =C2=A0drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> index 14aa2ca51f70..81179c60af4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> @@ -40,7 +40,7 @@
> =C2=A0#define IXGBE_SFF_1GBASESX_CAPABLE		0x1
> =C2=A0#define IXGBE_SFF_1GBASELX_CAPABLE		0x2
> =C2=A0#define IXGBE_SFF_1GBASET_CAPABLE		0x8
> -#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
> +#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
> =C2=A0#define IXGBE_SFF_10GBASESR_CAPABLE		0x10
> =C2=A0#define IXGBE_SFF_10GBASELR_CAPABLE		0x20
> =C2=A0#define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8

LGMT.

Acked-by: Ernesto Castellotti <ernesto@castellotti.net>

Kind regards,

Ernesto



