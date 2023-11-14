Return-Path: <netdev+bounces-47594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B909D7EA95E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D49B20980
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 04:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1F8F76;
	Tue, 14 Nov 2023 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqyz+/mE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA129474
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81247C433C9;
	Tue, 14 Nov 2023 04:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699935137;
	bh=W9M0gdnNmo/iFaQEqYz6VwfNIbLegUgx6Nm7XrUcdv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fqyz+/mEDOLtPeD391H8QwRguzC3HYKbFWT1+l9FWnUWtHzfILtLZgP41RHlBpHUx
	 xkceMkWUWPbWph+kW2vLwtFfU8w4cQ5cOXZaBAfZWBnGe6J42TWIW4r0N86hCtfmYi
	 ANi3ks1zqcbgVyuWlrodV1EjGZG1McEOcYVRquzSLx7fqIII3CpLd2ziFLUz3WGskg
	 f5p04MXqCY78oiXXKWiK13FiltDw+C4qLy6umtU4rsuxqsIqwNX0soLe/unqB09tH+
	 ICUNS/tPp/0zU4Zb+26wX4a82r05OMBxLlp88ktaT+bLZOtf8A5lXT4UFd4+rOp/zF
	 qa7ou1g6JjfcQ==
Date: Mon, 13 Nov 2023 23:12:14 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Vlad
 Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name
 allocation
Message-ID: <20231113231214.2131a1da@kernel.org>
In-Reply-To: <20231113230902.7f342501@kernel.org>
References: <20231113083544.1685919-1-gal@nvidia.com>
	<20231113230902.7f342501@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 23:09:02 -0500 Jakub Kicinski wrote:
>  IIUC once we cross into 3-digit IDs we may crash?

Not really crash I guess just repeat some numbers until the end of
the buffer.

