Return-Path: <netdev+bounces-216042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87635B31A93
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078E77BF50A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8B3043D3;
	Fri, 22 Aug 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzq2MzCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3A2EB84F;
	Fri, 22 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871310; cv=none; b=dRFOczdtYxyRaw8f7N/cwTBG48K++Qz0CiO/Zfqi+fqpRxAtWiaRzpz8tOWO7qt58kUiYUJjFemopLy8sYG5Xz8tmFNO/JQ/FIBYxKsHkHKWPQ+wv5ATZWRrMb2OVXCQ7cFbDwlFXOv7zbrvNmNl51PwRBFz/QHWHkRHXcXHvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871310; c=relaxed/simple;
	bh=9TuER9TVfaawHAu2ZzezpBnq2eWkpUazPrpKKrgYpg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z63/NWgWW3yL4LyuOkHFJX3feqGTaJvJle2O4nR8Qbg8trgKkXuQzRY9i/Y31sXeaSv2upbcIzeVvgINSNZPWcOOCeRPv+GgKdTWO4QPwd77yytGdZ18rm72pKKxKvo1+0jokvnaA56S+b0tLctB7Cb27PAGPtTuSmtmxZsA+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzq2MzCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6274EC4CEED;
	Fri, 22 Aug 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871309;
	bh=9TuER9TVfaawHAu2ZzezpBnq2eWkpUazPrpKKrgYpg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzq2MzCZieMW0wVn6HeGXsec3xM34igLkKufPD/dfIvpyGhjVevYzUJayUzXn/5nz
	 mgpZBtnBHLy90AIyUkfivIFoXXL6tdtKEPmBTmOzwEgUlUSMdAEFD4iSbgkVFbYEpL
	 v25TUu0kLym28YxBVZs/h+AINUBuzJwDvCY+Ao5w7D7lFn/WEm6G+NDM6kYF2de4lc
	 jrHq5rhiV9D5TetJZjn3LF/Z1X4FFFUTYjnrZmbY4Af25sNu8KLYRnvS7GCDOQJNNp
	 806g3WKhXuuHp4SDHN73qMPNrUuu+J+rCED9fJG8BIFnAMp6U/wmBDI9OMpnCZivhK
	 2q84RQIt0HPpQ==
Date: Fri, 22 Aug 2025 07:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>, "Andrew Lunn"
 <andrew@lunn.ch>, <linux-phy@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <nm@ti.com>,
 <vigneshr@ti.com>
Subject: Re: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID setting
Message-ID: <20250822070148.2e23c3f6@kernel.org>
In-Reply-To: <DC8R5IJ2Q88K.YKUE9X9FZRNK@kernel.org>
References: <20250819065622.1019537-1-mwalle@kernel.org>
	<20250821181850.6af0ff7f@kernel.org>
	<DC8R5IJ2Q88K.YKUE9X9FZRNK@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 08:45:33 +0200 Michael Walle wrote:
> On Fri Aug 22, 2025 at 3:18 AM CEST, Jakub Kicinski wrote:
> > On Tue, 19 Aug 2025 08:56:22 +0200 Michael Walle wrote:  
> > > v3:
> > >  - simplify the logic. Thanks Matthias.
> > >  - reworded the commit message  
> >
> > This was set to Not Applicable in our patchwork, IDK why.
> > Could you resend?  
> 
> Won't this patch be picked up by the linux-phy tree?

Ah, poops, you're right! Let me adjust our filters..

