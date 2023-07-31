Return-Path: <netdev+bounces-22881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D45769B62
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4571C2096E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03919BA7;
	Mon, 31 Jul 2023 15:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A018B09
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80DC433C8;
	Mon, 31 Jul 2023 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690818848;
	bh=s0kAjQJcavEtn4qvC3HzqyRFEFYgPphknK2SvtAotiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ai5cILmtb3ikR461b8t7idKX14GQLmt2bs/fBuBiOKhKc+OryJNDPvPleFOOZTVlc
	 HmshJ1DkT3qyLODzm6f4SpXnv8+U3LBo31m3Z17rA+CIfHwe4gm2oKWJk87lCMsgSE
	 VmSxUS9E53HwBkcY4fkB166eUYdM9KDAH1kkkkSsw4mBqgGOm94IcY/dOS2yfD9wWX
	 ZcmsLKcbH55gYPozq7qpkWENSU79Fgm+QIrcahW9o5w469Pa9DjjKw0TGGEMKGVcZU
	 lSJGonui4w8fDPFS/pUly4U4Y2r/1p/fY1Ku5X0siK5onBeTBT4SlU8QJaIN2oKqX1
	 UQe/LZhANotNQ==
Date: Mon, 31 Jul 2023 08:54:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, michael.chan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
 simon.horman@corigine.com, louis.peens@corigine.com,
 yinjun.zhang@corigine.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 bigeasy@linutronix.de, na.wang@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v1] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <20230731085405.7e61b348@kernel.org>
In-Reply-To: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
	<ZMdfznpH44i34QNw@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jul 2023 09:16:30 +0200 Simon Horman wrote:
> > Please apply the fix discussed at the link:
> > https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> > first before this one. =20
>=20
> FWIIW, the patch at the link above seems to be in net-next now.

I don't think it is.. =F0=9F=A7=90=EF=B8=8F

