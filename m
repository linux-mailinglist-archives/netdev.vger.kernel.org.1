Return-Path: <netdev+bounces-15675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27947492A5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72501C20C6B
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5C628;
	Thu,  6 Jul 2023 00:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE697F;
	Thu,  6 Jul 2023 00:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C1BC433C7;
	Thu,  6 Jul 2023 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688603576;
	bh=SxToegb9EyKIFdv1OBaPTdNlHieL0BpHWUzbK2lynUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMOV1W7nCoptjApkxA+zGK3fStPXpnzRFLb1YBeE7Xq1X6CEd/LbT8wJ42Ysxqqjm
	 1p1pgR7PmMq9E5rv3/Ly28njbTJRS4cFZMGLyOo4I5Jwln4QCaABxsBKPy/unTRXuv
	 e9zmGt+ej11pC4VhdtpEqQ6L7/odIS1nGexK9oGxl2DgIqDZheEBGpRQzlMDs+mhLj
	 XqZwLKm8pu2JzvE0hqYyS0YX/K5+6jLVKbA2flDkQWpou/r5bL7s8rTfbz/3bNMRq5
	 UrgS6kPpdWI+pkeTf75X0Y00N6pk8jMaTPn4hbtZLUdyzrz4u+9jY+BuSP8QAIYoj1
	 zVDWcZG8jcdWQ==
Date: Wed, 5 Jul 2023 17:32:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Subject: Re: clang/llvm build broken
Message-ID: <20230705173255.1cee9e08@kernel.org>
In-Reply-To: <20230628200659.4a265b99@kernel.org>
References: <20230628200659.4a265b99@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 20:06:59 -0700 Jakub Kicinski wrote:
> Hi folks,
> 
> we forwarded the tress but it looks like the clang build of Linus's
> tree is broken right now (at least with clang 16 and 17).
> 
> Song reports that the fix is pending. We'll try to send a new PR
> and forward again as soon as that's resolved. For now we'll need
> to ignore the failures.

Clang 16 and 17 should be fixed now! There is still a dozen or so 
warnings in SCSI but at least it builds with WERROR=n.

