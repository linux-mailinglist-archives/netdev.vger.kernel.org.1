Return-Path: <netdev+bounces-212462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD83B20B1C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032AE188A086
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A720F070;
	Mon, 11 Aug 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbu0bVF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D01F463F;
	Mon, 11 Aug 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920868; cv=none; b=Qq/shvzmF6XDZkeO245gBqb6O4B7LkBHstB85bGzEbtGzwPPZuf5joM3o5SSMrdAc6F/vfQNRmxmFZUJXKHRPVoi4bVRsAfa5YS9FO/59XD/viC4JY/vEyvPxGVkbL3Gow+Te/RfiMiMDqoSzd2AGz6vp+awjvPH4x5ewUKyuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920868; c=relaxed/simple;
	bh=uQniO9yTRPCI+mhHnRFDExMcDxev04En5ujX3TtuAP0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ikSaubOHfcf5d4IgashiNogXcSJ8ih483sxVqXlK5agvVshHjJdNqSu1KZLWlKMnnH2lBQjAwo52xT0trcMCR8Vota8cDvYt/9qA02MP06/gNutSRx1g0Y/qVRFD1LQeqgNqDXbUs1JfJXpv0KXVs7v7Jvoq4BykabQCdWN8Kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbu0bVF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39223C4CEF5;
	Mon, 11 Aug 2025 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754920868;
	bh=uQniO9yTRPCI+mhHnRFDExMcDxev04En5ujX3TtuAP0=;
	h=Date:From:To:Subject:From;
	b=Nbu0bVF+nvlcSjC0AEKKZ5v4eAz1wg8GDHN+j/zGSQkOHcNKKhL3p0yChcMcumWUo
	 DfPpJ8KfVgEeWfIYeQkxOKCcSFYm5rWY4357PToJpDYR5my/fHS8HngRHEyuWZwczy
	 WCvf5AJgePnIOyR42x2wNOy9bn0f1K106XubrtIaorjAfxIYQMWWgl0vfMsT/BiQXo
	 RE5aWm9b1Mp+wang+qKopok8pnBbWs8iNBrh/zXh8aw8Rmor8fbq5FbXQCagqL0nTh
	 AqfFd1fa7iCHqeKmzdb7JPipV+iSHci/A3CQLU/nBtV4bh4rZ9H6iXgwdwVOrPcQke
	 mxEwNknkDbQ5g==
Date: Mon, 11 Aug 2025 07:01:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20250811070107.0ac93109@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open again, gathering 6.18 work.

