Return-Path: <netdev+bounces-183513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DBA90DF2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4DA46000B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF0233144;
	Wed, 16 Apr 2025 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKxZCNNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16D20C497
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839889; cv=none; b=MNOF2HcMq5z56xkapUo09845PWp76bEMxximoZt9Nmb6tyi0W5S9/ftMIbnTg5NySn6FBDju4iJjUf1p9/KMvW3v3zOJs9EE50Zcn/onBKC6C6FsD/HdNqitaUdZdk7L7sFmDXZLLXmAE/zGGdhHrKxgeXa/QTz2rvQEoH/ifEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839889; c=relaxed/simple;
	bh=01Z2kn5a4gonni9b60GWvMhTbeN4kqMq3u63piqLg1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hves8p/CZrRESSukRJOtt3JwiLfNHqJhNCM+Nv6PySChRSO+ezZvkEt+oPcE9YxDz7fWJc3Qe1zZ7K6iT91NOvTg4W3A6LtnQjt9RBI6sw7stoQfk14zjPx49bJgCwWXAlcAyEGaFHOC3eZJ5iz+4PEUlSLSNBG1a1ds7TJL7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKxZCNNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE46C4CEE2;
	Wed, 16 Apr 2025 21:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744839888;
	bh=01Z2kn5a4gonni9b60GWvMhTbeN4kqMq3u63piqLg1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKxZCNNvjNEdfRjI5Stq11nKS7wfEfsrj/44rIj5U6PceQjkGHEbp9K9l1nSOF+uJ
	 MnzO6acQ/3zp0mQa9YK56lsxJFJWO+nmIb7C63CHrOq/ITYGwyQyw5qMoQ1vRsaORA
	 Tx3fpNk7vNvhFLfaxuup+83MRutoF87Oa430RttV9MqYotzvdjQBerFxlurxMQpIDZ
	 3/4vUn7xihAbNHcDXmqKNJ6z72mhOGxgeRNO56MQUHFglWTi+BkhBWtGt1jcpwAPuI
	 qx4cq/cHNCwDdlYfImH1Gg77GSIzDvsDHLFxtH1IGwvNOGqnJfWXUqhTfu4HuihjsI
	 6MZ7ELefznH0Q==
Date: Wed, 16 Apr 2025 14:44:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 1/4] bnxt_en: Change FW message timeout warning
Message-ID: <20250416144447.1fde7ada@kernel.org>
In-Reply-To: <CACKFLi=tvPJXk4zFXxFzWftc-AVU+2m_cg+EFTzs5MSoDoWFaQ@mail.gmail.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
	<20250415174818.1088646-2-michael.chan@broadcom.com>
	<20250415201444.61303ce7@kernel.org>
	<CACKFLi=tvPJXk4zFXxFzWftc-AVU+2m_cg+EFTzs5MSoDoWFaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 14:41:10 -0700 Michael Chan wrote:
> On Tue, Apr 15, 2025 at 8:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
>=20
> > sysctl_hung_task_timeout_secs is an exported symbol, and it defaults to=
 120.
> > Should you not use it in the warning (assuming I understand the intent
> > there)? =20
> Yes, we have considered that.  This is only printed once at driver
> load time, but the sysctl value can be changed at any time after the
> driver is loaded.  So we just want to use a reasonable value well
> below the default sysctl_hung_task_timeout_secs value as the
> threshold.
>=20
> But we can reference and compare with the
> sysctl_hung_task_timeout_secs value if that makes more sense.

I see your point.  We could also check against
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT ?

I noticed that some arches set this value really low (10 or 20 sec),
it may be worth warning the users in such cases.

