Return-Path: <netdev+bounces-96062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08CC8C4289
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A22877B0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC815357B;
	Mon, 13 May 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JknM4cSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CE145B10;
	Mon, 13 May 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608306; cv=none; b=MnF5LhRSj9/7NkTnnxciciQ0IEuzU3/jIyLmcSjPPi/oCkYRAO70hkw57X2NA+EEbJAixBGisyrCivrzTIPNMS/52UpXRSC65NC2QCRZ58G+nkiXnGrr8ESnNrUW+SIu5UPvZ1kezvIC7YEq7wMB8BOGZpiXtNoviKGCDkPQll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608306; c=relaxed/simple;
	bh=z5SpRYlMgMg120q1y01PrNPdm7F8MSMScjvCrHAVIdg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=kUQHb2J1nRimKvGE90Vq4KJ6bfnEakVuWVmuQ02eo80FwVgaKBLjdZFyGdKLjNbr4PdpSez96b5HGya98ZKY/31g7JuFf9VFlvJlEhTBQuapd/v4js3TBdvySbhBoywSiQjdbxCKz9Pt9PcdUAfoelB0AlO1n+HiZsqGMWUqAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JknM4cSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D02C113CC;
	Mon, 13 May 2024 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715608305;
	bh=z5SpRYlMgMg120q1y01PrNPdm7F8MSMScjvCrHAVIdg=;
	h=Date:From:To:Subject:From;
	b=JknM4cSMdruKC+jfPRqiqIGjoHxj6BzEnfFZfF1QebPAlw6IekyU4lFdQl4ulV7Uh
	 SxuAdr6uHn5ogrsz2NKvax0vTqUVTgARFlsz8ZZiZbW3wN6GBKi2q39o9UjjqWVzoy
	 DWgzL6rJIi/pqxzvEGfoGrUkUyBkkyYRO4H9yaOvNnoHAyBAzU3hgjWqRvH8PYK8GQ
	 J/QphcB8z564+edleTlHP/K9PJU1e6kfZEkY4T4pnMzD/AG2yz1/TJf48fwGWeIC2n
	 RZXC+vXsCHPbw2EpLSenWcY8x01u8G7i/wGf/JWcueTYce1iLHHcESOfbZz5fhTGn0
	 BnGwkpYkjYOMw==
Date: Mon, 13 May 2024 06:51:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20240513065142.58e68929@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus has tagged v6.9 so following our usual process net-next will
be closed for the duration of the merge window (next 2 weeks, until
6.10-rc1 is tagged).

We'll go thru what's in patchwork already, but please hold off
posting any -next material, or post for review/feedback-only as RFC.

