Return-Path: <netdev+bounces-49298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC57F189E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9C91C21228
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728F1E516;
	Mon, 20 Nov 2023 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5FiXsDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA621DA33
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 16:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90994C433C7;
	Mon, 20 Nov 2023 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700497686;
	bh=9JBfn1ONMcmxNC9o8jdLY4A6lh+CyQcaLZ1ppSfApx4=;
	h=Date:From:To:Subject:From;
	b=P5FiXsDz4o4RPxK5F7XgWz7QTFzCmL384ea3DAuxusgEAIQKdXUc/34R0kZIb6JVN
	 XBmkqT+uT8euF9oelcVl7KGQfixANtc5QDH/oy5sUFTDC71lD7CKGXddsQ/tNUGeFO
	 zwQORAiKlAxcTPEfU/RIMpe55B9f9XW/KES2XyrxxRdyvBkZjWGmMKb3EK06JTFnN4
	 FkMDDI1jg0jHMx/nPdtleG/Jwc+sU60yihXR+AElsUSKTqZpgw3n1wWW+ASXZXnyTC
	 8FqX4dttxEc1tY99jaXE0tdlF7qepmqXm/M2lc5Ag/XVLFoB9661d6jjoOK2Ei4Zpd
	 0hus3+DQJA59w==
Date: Mon, 20 Nov 2023 08:28:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Nov 21st
Message-ID: <20231120082805.35527339@kernel.org>
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

So far the only agenda item is a minor update on CI,
please send other topics!


In terms of the review rotation - this week's reviewer is Intel.

