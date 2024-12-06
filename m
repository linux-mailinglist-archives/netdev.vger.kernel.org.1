Return-Path: <netdev+bounces-149540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD049E6283
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BAD283859
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942C1CA94;
	Fri,  6 Dec 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2vytCP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDB1EA73;
	Fri,  6 Dec 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446309; cv=none; b=R8qTbM1QsYPed2LH8lcfCN/Zz4XVN9WS7u38xIdMFWCSD5VyaP+kLRsddO+cw+AZXIDAwRWU6griaQ3GbKOzDE1+1XauQkjl2nGoFzhJXHBacDzRFGGVZ6MKKc/1ui5gDiCcVpZ3VemnUfd9wBVe1NZWBuUOmiSKq0QTB0HseWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446309; c=relaxed/simple;
	bh=QZc6LCP6//qnOLJE9d9M3GmAfdrCqCSoKb3OBF56EK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrVMQ2QP4XJOYC13y1iA4kMMrkRxayNzH+1QeQC/dMDZj6Tz83wGL98nEz2TeDKP8SkcFcj+Y0RbAJijOfjt0+q9HioJtqSu4WKeOwIvcAHrd3qAl4wA5QSkNNdBNRcb+NL73jPdIPOBxVoTM1u80IVrT+Klo7C1E+L7Jggr4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2vytCP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8001FC4CED6;
	Fri,  6 Dec 2024 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733446309;
	bh=QZc6LCP6//qnOLJE9d9M3GmAfdrCqCSoKb3OBF56EK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2vytCP6XBNqbDICE/u+XOvxlUIUXQUQ2+0yrYalTT+nY0TpZzkJ+pYbD8sI6+XWi
	 0bQFKe2fFaBQ0IMn8w77Yikqz288s7oBDG3vElXwdluc1ctK3d47hfEaYKTBP4kXI2
	 cOTpBjzdRLUCdR0sU28dxWbVZTGGpgZVHnWGDa2PbWy1gZC9YGima1hUoNk645qhV6
	 kFP+jmM20Wsp18IhXdVSM2SDzrU+LZru8UuXkh3UdzOWLFeVFDtePtC+h8yOxAdXkb
	 oGo2Cyd+eUPUBWScPej4tXzkECm4azGn6vR9EuiJWkGd6+X2XYx7Xov8eFA6Qti7eh
	 q1ai6a3bKhK8g==
Date: Thu, 5 Dec 2024 16:51:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Vimlesh Kumar
 <vimleshk@marvell.com>, "thaller@redhat.com" <thaller@redhat.com>,
 "wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
 <kheib@redhat.com>, "egallen@redhat.com" <egallen@redhat.com>,
 "konguyen@redhat.com" <konguyen@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 RESEND] octeon_ep: add ndo
 ops for VFs in PF driver
Message-ID: <20241205165147.2f7a7ae8@kernel.org>
In-Reply-To: <PH0PR18MB47342ED76DCB583E62078808C7302@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20241202183219.2312114-1-srasheed@marvell.com>
	<20241203183318.16f378d1@kernel.org>
	<PH0PR18MB47342ED76DCB583E62078808C7302@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2024 15:47:29 +0000 Shinas Rasheed wrote:
> > I don't see it ever getting set to true, why track it if it's always
> > false?
>=20
> In case we need to support the api in the future, just added the
> corresponding data structure to track it. Perhaps if you think that=E2=80=
=99s
> warranted only 'when' we support it then, maybe I can remove it. The
> data structure was used to check for 'trusted' when vf tries to set
> its mac.

Yes, please remove it. We try to limit merging code that's of=20
no immediate use.

