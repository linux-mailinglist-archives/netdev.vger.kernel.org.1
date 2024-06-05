Return-Path: <netdev+bounces-101116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C78FD664
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF293287E70
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A014E2C4;
	Wed,  5 Jun 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNp4W4WH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C414D718;
	Wed,  5 Jun 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615412; cv=none; b=NlpPrXIs8m1Uq01xNjy7lG8Kk0OoiYOAInKSXVDmSxkD0+2b7oMXflWBXfSRnerAlmyO4BqkxAUrFjgRrwGJOsTlz+0oMwGvYZ9kaK9I7/E2pp1EkOWoUq0klJRcsjmjc0H++MFXEzpRM+mAT+RN5C850kerRnQ6HcZvbJromtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615412; c=relaxed/simple;
	bh=v0ZBjHselCH0FnO+7f4gVAoxhTchkcNgPzoQnP2TASA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ389TXaYB+A5CJxANEMLuL699ARyo7pe+YbpBwtUb6Q2orrWJQQe6yEzdF8JxbtD1SZKmhSKKuM2AYwN5bdhkzhKD8gdr/WTa7qq1ec1pFmk3Msln72ifwhdHV0zH4cGjo5FdbWDFK5mEBDh3Y5JlljC1TjpKQpwTqRjXnP3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNp4W4WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0233EC2BD11;
	Wed,  5 Jun 2024 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717615411;
	bh=v0ZBjHselCH0FnO+7f4gVAoxhTchkcNgPzoQnP2TASA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNp4W4WHRLYFfvZPpCaZJp4SOUtOFCbaP+QtlILPMr6iCLC92eOchVAu3vzw+TTGO
	 9MF3wOIOTBOW7thB/i+jJzB4d8y91YhyR6tNqPnzan3d2sZv6KEjP01ZhVW4/JJEui
	 +PbajhaLxeeLbvJlcFhG2ysBeXJsbVxWKrNVC69n9fgwwciFP2ZLL+COkUw/XHT7YM
	 ApOf6zg5UQGyeg9tdFVSfGC1O79CDmIgNbES8/+D99Wv0fDZ5QUII1QICxsubznHGU
	 lapLi7aJnLv5V+Vvbzp3XlES1ogwOhJa0vzXGMhBIxhdFTW2TeX4EMXAmQaJUi1Dg7
	 swXxA79BuLGGQ==
Date: Wed, 5 Jun 2024 12:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Udit Kumar <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
 tglx@linutronix.de, tpiepho@impinj.com, w.egorov@phytec.de, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Kip Broadhurst <kbroadhurst@ti.com>
Subject: Re: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along
 with GPL-2.0
Message-ID: <20240605122330.169ea734@kernel.org>
In-Reply-To: <20240605155659.GA3213669-robh@kernel.org>
References: <20240531165725.1815176-1-u-kumar1@ti.com>
	<20240605155659.GA3213669-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 09:56:59 -0600 Rob Herring wrote:
> > Cc: Kip Broadhurst <kbroadhurst@ti.com>

Kip, ack?

Failing that (+1 to I'm not a lawyer, but) Udit, you both have @ti.com
addresses, can you confirm the intellectual rights are with TI?
In which case we won't have to wait for Kip.. Obviously easiest if they
just ack.

