Return-Path: <netdev+bounces-90220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67218AD2B4
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487F4B24510
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C9153823;
	Mon, 22 Apr 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqZiu4FC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3A15381E;
	Mon, 22 Apr 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804574; cv=none; b=aB7o0lEUPE/rhj5QtgzTeFpL/f7a37gJes/jxfREIn9X+9/6gkvXqh2w5Lw0kehxg7v3w0z95dcemukfyQKdUt72bjxVojp51Wxz23BokB+Y55+o/RPty0OX4TtIIUjK8DY7/bVSh3uMGQSC3j7gCgAhwg3zr+b5+6whV6G+AWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804574; c=relaxed/simple;
	bh=sOI8dPPTCFUGwv2GmqUrgz4IohAk6HM2pqYdJwbjgl4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RqM1RzcdQkvWmEIhpfdPrDAMZMOt1P5ks5+XtHvtuJdreshPhJxWxRrGX0molCYgmMPwsoN81IIiKdWfc/wp5/uiBynVgbvmQg9K3FIkv5pLWhjSk3z1D5NX7lhyURAnWYnS3Dv8bp8Mdhg+FO6OVRuhlGdqWXtawbv98cRxoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqZiu4FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88915C32781;
	Mon, 22 Apr 2024 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804573;
	bh=sOI8dPPTCFUGwv2GmqUrgz4IohAk6HM2pqYdJwbjgl4=;
	h=Date:From:To:Subject:From;
	b=aqZiu4FCzAEM3rxGGot5wSIaSh3alJo/TPTdQY6Ne+Ekgj2KoVTIw8c+Tou+MY7x4
	 oosf42/BfMyFNLZm6ji4g59kSGnRm5cM26e1QjGg4ULcPY8X6e0v90qvnZJ1vv/avx
	 kimho/VGft3V2sCql2aE3UhdyBpVFljV0QP2Tc8nKtz13Eao1zwbx6s4Nqzo8DTXtx
	 oPG/JpZssDSwJWjRoemjyg27PzDazd5B8LxxpndBnedI5yd8nQrGZIZmBTW+fO31Wm
	 10mfbQ7f4tetLajgbVBmFihtye8+KfbE3Z/D0ld22Rm7lr0JU2dDEMsd9DZz58w9m2
	 lW2I+3e2Fu+KQ==
Date: Mon, 22 Apr 2024 09:49:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - April 22nd
Message-ID: <20240422094932.4dd0fc13@kernel.org>
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
5:30 pm (~EU). No agenda items have been submitted so far,
if nobody has topics we'll have a casual chat :)

See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

