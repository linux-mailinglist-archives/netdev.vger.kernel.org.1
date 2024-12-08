Return-Path: <netdev+bounces-149948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E39E830C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223A016585E
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDDC149;
	Sun,  8 Dec 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgHy+z55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0A749C
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622901; cv=none; b=N2kFn5fGpU4xK8K63ZlSG+7H/OOVgDpphBoOSu44xV9RSR7F3f3TYhalsZFWuy+yTDGayj/57SIf2Za/h4w5E2xpJxuykHFxMVU/eYV10Vg037xzlD1PKl6es5I4tFDq0JV+wzBY38f+GiG/nqtDtmWIFy3IWBe8B2fNRGOWoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622901; c=relaxed/simple;
	bh=mO6YVKl78yry5eacwPpajE9MBkKAS1voq0ECLHf/Wvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riLSaWV7FDjxAncdjD5iSc770cpBk3YU+WJ2w94jMa7aFyhP5cqtQPOU3EJfCzLRvTh30jare6eK4BTQmSu//9kEmjxPsPFwQACOVFa+e2oyOJLyRNj/lpKopS7cvfE0xpNKYJwHcmS6wSwaVIqpNcjPy0+otVtO9PhdVgbQTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgHy+z55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57CC4CECD;
	Sun,  8 Dec 2024 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622900;
	bh=mO6YVKl78yry5eacwPpajE9MBkKAS1voq0ECLHf/Wvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgHy+z55ukDGEKx3w1b3ghSxOLVySLcDYnOzMREnIB3xdTIHxzc8QNWvLFLZEy2Pk
	 9aXbKg07avec/GrrudYjTJN9DwO10aJCyvhOuKLRPGFQfeZ20NKwXdQ2S9CZQN2/6Y
	 ABRuUumdqC22d+6H29tRIdk08afRQM9eVMXFAkdYkgoecY4S9LUbM8nccsYXhxFnDW
	 zKDsp2FmEKs1ykoz7Dcw6NZsmSBHsR1kf4RRDVxRoFH3+iSGhlJd/AaViCNMfv1hPt
	 NWAmUQeuIgwuwxePDnmS5P4+KNjJu0Ggwed8G7QkqNvI+Y4wYMt8DBUTqIUalKc7XA
	 OMkLwTHln27yQ==
Date: Sat, 7 Dec 2024 17:54:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tianyu2 <tianyu2@kernelsoft.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv4: remove useless arg
Message-ID: <20241207175459.0278112b@kernel.org>
In-Reply-To: <20241205130454.3226-1-tianyu2@kernelsoft.com>
References: <20241205130454.3226-1-tianyu2@kernelsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 21:04:54 +0800 tianyu2 wrote:
> Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>

As Paolo already pointed out the name portion of the sign off tag
should be the Anglicised(?) form of your name, not the repeat of
your login.
-- 
pw-bot: cr

