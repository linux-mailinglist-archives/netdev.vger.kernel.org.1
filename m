Return-Path: <netdev+bounces-98267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8B8D089F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF61B2F22C
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24B15FD0E;
	Mon, 27 May 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8LWnVJX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426138FB9;
	Mon, 27 May 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825623; cv=none; b=qHLO77ZZQnEyQl37OLv1mlqcq7zd/cI5Hac2iqHS9jXw9pHQxXlgw+z+SukKxP5WT9bO1tCXIUlGOS4bU33Nsf9PZ9vvG6HPUqtj6gQYCKJ+etxmxZAjOS6LaBE3OuQDITt9IvhMLs23cGP4/mn/zDVhwxnrht/R4TU14gid8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825623; c=relaxed/simple;
	bh=9GHqhaDBmUxf4KohC93mWzQkJzfhHTWfk5A6uB69vCc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ub4EaEWAVwRjmLENmQhauPSXjl5bFrSm0pUw1FN+erc3YeQHMw/EUcl/KgPEcfPAlcd8pEPUQU68rudHFTgO/sk2cF4espoaaPHClY9SEvH7GHo5VoFJ4SxDRSYaElaQzPtXhEgWaTVTjPYsczA3Zzvt/lx1KdrAQ/U1sUiJClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8LWnVJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF46C2BBFC;
	Mon, 27 May 2024 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825623;
	bh=9GHqhaDBmUxf4KohC93mWzQkJzfhHTWfk5A6uB69vCc=;
	h=Date:From:To:Subject:From;
	b=p8LWnVJXhCYUS0TJioSsdMmJHZ5uOxONlwvPBVX05H9wThmQSqiNEtej5e7bQyYlH
	 UApKjTZG33dm/Tl8jWuXhgGsY7ZN71CQAzuFmk7iaWFMJMr2k3S1hJc5PFpe4SqZsA
	 24i64uMb0GeU82nfQVZovCh7WXBA4nHC/Z4Dtq1BQ30ljRZIQ3Qnyzs7Brr9TZpQlu
	 sw4C89MINfKQOvw0Vu/wGA2AK5+TAzsYU55n/JHoKFNSOsA+MOZQBr2Cumzs3CjKyJ
	 B3t4ixukC+fC6Bvg7EPnvLJ/98nM4TFm4nlKAqpSbWwuXEFqaLGMoRWbu28tBYAqrI
	 t4QpOWJSkNDaA==
Date: Mon, 27 May 2024 09:00:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20240527090021.5bb6756f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

net-next is open again, and accepting changes for v6.11.

