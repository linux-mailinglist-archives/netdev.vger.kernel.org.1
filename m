Return-Path: <netdev+bounces-81624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4988A84D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD9344066
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843C73168;
	Mon, 25 Mar 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKA8RdVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E46CDD6
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374467; cv=none; b=TlYtUIT/HbBZdOtEQXsKYfHZ3xlXNrELL3/qRBBF8oj1DI0wYuapAgQJI+s/BqjTsI1QcYR32N1WyyyKGkixiVhjWVxS+kq+KMmytGJzPQ+/zMNi4R6aI6jR0TdeET8bvUOMC24x4cfOawPvpJMlHvU/ShnsO+CNmslfINa2HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374467; c=relaxed/simple;
	bh=OOY+rJ/fO+OJpUdjT20U7syJD4jD6O4XdAPbb1dyRSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PqH0zAGoR2iArt0GMPkEoiMdebTki8Y+/XXOXGkxtWfxE2S1SZo1BmwlBwBzcFNE2WEakqtGLML06cxLms9A667u7KN3nCujV3KWVMum9bROmqP187Wx85QK+xlaqR+fb6UCKAkltiXGTi+kgEghAftOjnWZyarhEvobh/KhDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKA8RdVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA76C433C7;
	Mon, 25 Mar 2024 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374467;
	bh=OOY+rJ/fO+OJpUdjT20U7syJD4jD6O4XdAPbb1dyRSk=;
	h=Date:From:To:Cc:Subject:From;
	b=gKA8RdVKC2Nu3sB3t7gE0Po8jy1E/U0TNvVBLl7FrLcBU2WtwMNoWmb/XAPdjq91W
	 SqCT4s07KAle2EB6H0u/EpM7sNnvE6zAx883c6OYzsPuJVYx2Y+qTkcmprj8tTFdl8
	 qRNpAAD73kdU7fsxwobV7KfjXS4Zxgl4OM9WMyNgjRA7yRWFT7/PSYSQdUGDzJRq8L
	 HlP4Z+RD6Zxmms6slY6Jx2PcGf8S2jZMOaKIL1uLvTxpTNsLkWOoH+XKo9Toxn+twd
	 JZTnJUrEmBakTCN740Do7MG584o41SN7QhRHtngDXMI1sGNZ254YyFZj0PVxMwMcbS
	 1VdR//Ad7Mvgg==
Date: Mon, 25 Mar 2024 06:47:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] TCP-AO got a bit more flaky
Message-ID: <20240325064745.62cd38b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dmitry,

the changes in the timer subsystem Linus pulled for 6.9 made some of
the TCP AO tests significantly more flaky.

We pulled them in on March 12th, the failures prior to that are legit:
https://netdev.bots.linux.dev/flakes.html?br-cnt=184&min-flip=0&pw-n=n&tn-needle=tcp-ao

PTAL whenever you have some spare cycles.

