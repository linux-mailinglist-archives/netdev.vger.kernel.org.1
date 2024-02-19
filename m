Return-Path: <netdev+bounces-73092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752685AD58
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3811C241C3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C2535CF;
	Mon, 19 Feb 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF13UbDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18CF535BE
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375344; cv=none; b=V5EemkiJbxoHDzbowsDlxMBphoepMv97behDDJpfudpvpsA/jL5HQ4+oj2PrejaZTeVxYzVUhqGplAILhOZlWf9vGa3eFvHhnDQS18MBGACnvV0bdAvncgRNAPXacYyhMPBEUSSFy2EHyROx307E+uH7h+6EmNzIsDMmGLjSh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375344; c=relaxed/simple;
	bh=FvLYPED4UknRiZKuYSrv/Nhd5voxYCc+8kuXzsMdn4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKdSb5NNgwcj+CwW6YeLxFdd5u2Ov897Dqe3k0VvcKseR2oAEBScVRtOlrujG7/8RvMSNCM8m6Gp1ENwB6Ou/4zffLs0QoVWaZ2bDFf3LYGBWHKStTph7/VggNsRd/KBPTJhmNWulti6L3ktpXlTgXQV4/USxhbiJNwNwVEBfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF13UbDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC343C433C7;
	Mon, 19 Feb 2024 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375344;
	bh=FvLYPED4UknRiZKuYSrv/Nhd5voxYCc+8kuXzsMdn4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EF13UbDn9owQlAyxv3Pb1EtJk7MlDvtMh9YbatGwpNMCuS2l65Tbio7ZtIPjkM4OY
	 WaQyY1IESA2wlS8l+Vd6comULpY5FIRTE8NJs45b9627DHgQU/sWPV+UjMLuACpecQ
	 SQ0JocFFZhzu7EnnRbRmZy2qft0NrZoaBvMAIrkA+H7sf+CdH3bJnq8yaDGxwZVkEB
	 qTJVJvltcxaR8MTZ6hzEfmoEPoBXg62r+AiRZd4N6tA9tFfBV94GnaGmmyLEZccGx1
	 Y+b/pad7XcX/U9DkW2xvQ7dYmHtiRiBiCOe4rmdQ2sIykZGVMI2P95T3GjJIGBLmk+
	 oZkYE8C+Y2s2A==
Date: Mon, 19 Feb 2024 12:42:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 01/13] tools: ynl: allow user to specify flag
 attr with bool values
Message-ID: <20240219124222.37cd47d0@kernel.org>
In-Reply-To: <20240219172525.71406-2-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:25:17 +0100 Jiri Pirko wrote:
>          elif attr["type"] == 'flag':
> +            if value == False:
> +                return b''

how about "if value:" ? It could also be null / None or some other
"false" object.

