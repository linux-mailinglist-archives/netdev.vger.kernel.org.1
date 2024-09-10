Return-Path: <netdev+bounces-127031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A2973B8E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C208F285E9C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0E19412D;
	Tue, 10 Sep 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhbRoA+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24697187FFF;
	Tue, 10 Sep 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981589; cv=none; b=VdjV6s70Y0gsQCEibVHiwZbVGNTWv/90bTMVLlQ9Xk8FAsd0EAK07nHL6D4muUWd55P9hfN2/b/Agb1vqHH4jKqZYILblVI1k1YePQTPkT8QE2Tc615fq4ZQrXvKJhIW1Dmt2MzN8I7GOgLGsn2D8ER+V9/2gd0E0yEEv+Vp93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981589; c=relaxed/simple;
	bh=g6MRt2X0IezHPsQOUsCC6hfgBU7YvQ6y7IEwJ4E2BkE=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hy8XwA4Md0GhAOctU+mIj5sAQLuXA6yABH9I3F25CrECKYpVrn5Ym3CQq+4a5W0thkyTgBp6r78zUFAjIFfmgwTOGIZJSyASTneDgD9agmu1FXQj67bd28LtEakjUwmZI4v3YbU0V3h9IASgvv/5sXcKrtyE5HwWzxzYkzCryd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhbRoA+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786BBC4CEC3;
	Tue, 10 Sep 2024 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725981588;
	bh=g6MRt2X0IezHPsQOUsCC6hfgBU7YvQ6y7IEwJ4E2BkE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=ZhbRoA+bkY6aUD/PhRR6YIskIrshkdmHLDG/qxqJ0/7SCIE9bRZB2aV8se997DeQf
	 gUp/Z4zHvMZCKgPaa2Cm9x0YbUpMaIhMspoKka/ulp1dkZObe48Sh8MdS0cG/AQ2TK
	 npalG++xO7Np3RCyJLWUXtkkxR13rx4q1DTeXLS6DAczN4gJe8SxPoh3TU2CLREDJi
	 gEZ6lV5vmRLO326Y7sUL9wpXSylqnDy7NzAR5WibD2r+XKLzh6RnMcfazr+nOYXoZ9
	 +gMVKA/G8JG3DhxC5muRSSt14LwaUvZyl5H6C5FGp/6YgdYcpIQ9XLxDyf8i640e+h
	 +sJulHngwkDsw==
Date: Tue, 10 Sep 2024 08:19:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Sep 10th
Message-ID: <20240910081947.2b98da16@kernel.org>
In-Reply-To: <20240909155146.1c19d5c8@kernel.org>
References: <20240909155146.1c19d5c8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 15:51:46 -0700 Jakub Kicinski wrote:
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> (yes, that is the right link, sorry for sharing old one last time).
> 
> No agenda, yet, please propose. I will cancel if nobody replies
> with topics on the list.

Alright, no topics, so - canceled!

