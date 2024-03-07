Return-Path: <netdev+bounces-78228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E68746FF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EB32833A3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 03:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE71107A0;
	Thu,  7 Mar 2024 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frLLRRI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DE634
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783848; cv=none; b=YS/8bY5CXoRT6Uc+O20O0lKSoN7jRv/UBvZl2+N5mZlJCSpnYhhh5gPgCHBi1YsA/pwt6i3A3OqZ549Vjxo9PxhBEwc1tUsi/O71c9gwIzZeOkJBciu8F1ob6zovsEUS1rBGJ6URFLvwjiErcd16wPM64MhooIMPaDUd9YTYj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783848; c=relaxed/simple;
	bh=Y26aSEmErH/XB3xGI32wpwBip+1x2Rb56/F5Geiv3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYiZt8Av022tzMX1YTdOcQMRyPx5buoQb8yaHGG/rTfhrH80RTP/Ot8agLcQUbsWD9eOI2XmHgtj7TaiyyOy2ldk3zcNjjZoTwBjfk0jGVt4Pbh7BorBQ0/9XISy6KVnBfSWP/if2J3UKf9xTmOzdf+AdjOtCaDWGw7UsoiDKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frLLRRI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE6C433F1;
	Thu,  7 Mar 2024 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709783847;
	bh=Y26aSEmErH/XB3xGI32wpwBip+1x2Rb56/F5Geiv3lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frLLRRI7xH4ottelCbgbKdXai/IfVdGdfICxGjwRliJ5dAVwpBROvfVEUWVjXzW+S
	 dfMuBkyG9bKeoui3hSyHVKJ+UzjUBzRWVliJ5Ry7Qz0tHK3c8u6K9tY+23Wjni8aTx
	 VRcx5o+bc4LIuCzZTT4Xoij06Ulk6yohPDfM5bd8y01Ry+NYkWj721vvGrhXtHMMtW
	 /FHvUtbQPXeomccIXpz+Rmj9Yk2hMAVkO6qvoXGYiAAnIpK7UEQVmfv51wYfAp2nde
	 JDI7T6V+y7X71CXOalGp09GCKHSBfFHR9IYASyDkAYPWMpejAVuSN2qlBBEBmx/xu9
	 t+glcDZmUIdUA==
Date: Wed, 6 Mar 2024 19:57:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: Process level networking stats.
Message-ID: <20240306195726.11a981cb@kernel.org>
In-Reply-To: <a76c79ce-8707-f9be-14fe-79e7728f9225@candelatech.com>
References: <a76c79ce-8707-f9be-14fe-79e7728f9225@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 14:57:55 -0800 Ben Greear wrote:
> I am interested in a relatively straight-forward way to know the tx/rx bytes
> sent/received by a process. 

What is "relatively straight-forward"? :)
You could out the process in a cgroup and use cgroup hooks

