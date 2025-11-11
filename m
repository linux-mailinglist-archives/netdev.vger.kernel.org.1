Return-Path: <netdev+bounces-237417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE459C4B2DB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869ED18835FC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3B341677;
	Tue, 11 Nov 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rabwyA/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282819CCFD;
	Tue, 11 Nov 2025 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827188; cv=none; b=Lxe1OAeuWiMcCNYc2f9hAJVvOVbnaMCWXgJFtDSQlhrdWw+nhioa1ix6msop0XFZz7TShEzdUm16Q2eILyjWiyiMANq4RNURwy2+0Fp9MQrFWasNkiHMJyju/Yzzacg9P/g14THjsQEXvrPc+hWBNj9siHnGH+Chx/PwG15sIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827188; c=relaxed/simple;
	bh=1Ri0DfcRggwPTmFPolyws/NpIVbil0D6j3dsoakvaOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM9Sr78GdTEMSk+atISCeCCvqg8tDprvoCW+84Ss0nEBIxvhNwEKPeshnFHeUGFNuzjiiTdd7SDOR5u6OESt3Fje5XTLRSg3/07Y/jhzXks/vOmxEatB6mdUQBDMxKcuyLFkUP0/q2otLAnUZZQxWfNCOds/WSV6yW5yznBn5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rabwyA/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0271AC116D0;
	Tue, 11 Nov 2025 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827187;
	bh=1Ri0DfcRggwPTmFPolyws/NpIVbil0D6j3dsoakvaOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rabwyA/YOj9GBdzd/l5+5I0nsonxaTedvc1+h+OFRTS2e/9iuhgRkrDIl/iFoGs73
	 fKlEsCCjtXJaLtY4oInzY1p/71NFEz6eXmHEkvk2lzmLWjDSSDc/Cfpug+F4tMi1CU
	 n///74+11iemO04SbLa6Yu45L3yk57S9HkFvAV306QNDlyUC843QAGFUX7PIwgC+iH
	 tSsQRed2Vw7rN/7FoTQPW26vLVXEeW1Wbkc4/qONNtHibmXpTtcAE6QZVbS7KZLRaH
	 n7G3FPTyy4ZVX2iC04MDKpWMEgvjKSD3h44zdzluf/hfF9MAm1LVNM4ojU9WVhgse4
	 IIVnHjKxHcWzw==
Date: Mon, 10 Nov 2025 18:13:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew+netdev@lunn.ch
Cc: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, aziz.sellami@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Message-ID: <20251110181306.5b5a553f@kernel.org>
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 12:33:41 +0800 Wei Fang wrote:
> v2 changes:
> Improve the commit message.
> v1 link: https://lore.kernel.org/imx/20251030091538.581541-1-wei.fang@nxp.com/

Andrew, is the explanation good enough? 

If the feature is inherently not safe to use with existing Linux
locking scheme we can't support it upstream..

