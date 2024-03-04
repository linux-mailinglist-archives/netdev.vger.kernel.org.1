Return-Path: <netdev+bounces-77204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E828709AD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5541C20CE1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7A78685;
	Mon,  4 Mar 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loSATYr9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB06166F;
	Mon,  4 Mar 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577339; cv=none; b=r7LgavaSR+fxwpr4OL+7wRp5hlzDQHiultq2mIOQifK1gLVjgFQ5yKYP4jNaDtKvZso2MbrMcw27fob4DyaDWBs+So4CUluTsVu2M8FO8MqKLzA7xztkpKBDkkjGEzi7UL8e0TxcwSkuV3axc9fUeQOLjMJbFHUJcAxBitBIWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577339; c=relaxed/simple;
	bh=cmiwaFRMkbsuBn4dC71rB8qsDP9XEDkvw9YtN+Q8ESU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=MACYMk1tMtrcrTjrnaBEgMpOLyouNfkly3ndyq8BvaBKkc5Nvvz6/JWwhrRpBJK6Lsxh50mQao3QAvZYEZxrlsTReDMjg8Hr8wM74JiU+3HcDw+Ps6Y3YvIsDqJ6yJuQcB/5XQNHzDmA2kbIK8gdYCZKHduk0ioSoQzGn1KFDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loSATYr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3216DC433F1;
	Mon,  4 Mar 2024 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709577339;
	bh=cmiwaFRMkbsuBn4dC71rB8qsDP9XEDkvw9YtN+Q8ESU=;
	h=Date:From:To:Subject:From;
	b=loSATYr9pXEz5auzyjkrTz40YCcLLuC5SolOqGCA6S7Rdo4lPI65QBQkNb2ZIkIQu
	 ltR12Z8MvqwVXOvXC6ZMcSJV3Bh+B8j+va+2jQNGcQWVSoE7vRvgWCLfIOA8tfgL1R
	 EvbPs7JAC137TcVLDabdUQsKuf6Miv0lfk6xhKR1G0OP6Mu/0jdkB9ZgOHDUcgpQnV
	 OEVT4OAybr/CDf/7EF8umcAUS8iNBCNGAACMDSBP7q/kzbFQs09uNxMh4NYvxNbD7v
	 HiAhJoBtRC0YnYvhyjPqfPDLu2BvyVUiPfL6EDmDsRnpF7KTeUznqY/JdJsadu6l0O
	 8D1U4Vm9xvXHg==
Date: Mon, 4 Mar 2024 10:35:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Mar 5th
Message-ID: <20240304103538.0e986ecd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

No topics so far, please reach out if you have something to discuss,
otherwise we'll cancel.

The reviewer of the week is.. Meta!

