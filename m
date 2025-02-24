Return-Path: <netdev+bounces-169069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11180A427A4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0F73B0F7F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59025A656;
	Mon, 24 Feb 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXZskhpM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786424EF64;
	Mon, 24 Feb 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413472; cv=none; b=rpBNmkgpioU9OAhV6sIgb/gQ22a07Z2i1TXNSvCEORau5dIbKMd83VohAf450O+JvRgXCsdehRTRftXfDEuKobPAykLvjm0Wn4FoPHYC6NHB4PisjZGJ4iye1N4nejlhQsnbBkPXyqR05/8uP/4PmljEHqYara8YONM9SgUtF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413472; c=relaxed/simple;
	bh=fnwS2B2MJ3PzimIODMC7aHdiZw5FGz2Tgb8Q5A2Tm5Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ATmSxT4YGAW2Ff0KqFj7esG9FA3d722dyNRK/NiYj6UP3cO7NG8QSQNTMI0vGVSKTUjCV/5C3ZQhNehuujNyVL8ZPnU9XLenO5ZmCjx9acaSR3CfZQO7R+q3ofPGWK/31EXtCL/GZFG2pHgGmAIoV+mfjcr2vNeS/FxKw9h4wuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXZskhpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D81C4CED6;
	Mon, 24 Feb 2025 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740413471;
	bh=fnwS2B2MJ3PzimIODMC7aHdiZw5FGz2Tgb8Q5A2Tm5Y=;
	h=Date:From:To:Subject:From;
	b=IXZskhpM5O/0bT9LqFrWtXm0V2Z981EQvBlV+1zzynlBwWqgVuFLOpgE1XnX8vOqH
	 Lt1ULtFjxavhUSu0IJ3nkWEygaFdGGo5/A/Yhld/7Msta/WJY1h/lUglp1wz4ioe4c
	 9OdN+8TxoyuZUM9yayxgn9SCaYNOgeM8IxckAhiCn0//9miaI1shOEErSGK0vDP/eq
	 c9UGm/A7615YGwmHMl+VZDffJZPmd3sTPBRrMJAtDQHpUgOhhFOA/NlhbY42zRh5Aw
	 BxjvMN07Zm4s3PFMt/dzMB0SniIKIRNVaBgOApQBd34QQsRb+BtMPlKmoK55cuB7Ny
	 UWY0KNOgQPCUA==
Date: Mon, 24 Feb 2025 08:11:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Feb 25th
Message-ID: <20250224081110.08be687d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'm not aware of any topics so please share some, if nobody
does we'll cancel.

The next call (March 11th) will not take place due to overlap with
netdev.conf.

