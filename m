Return-Path: <netdev+bounces-13852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00D73D5CD
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 04:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392AB1C208C2
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0B4A02;
	Mon, 26 Jun 2023 02:31:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED47F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 02:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56AC433C8
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687746660;
	bh=lRF0y4f2CR2aTLfKiE0p35EzO9GcOCwcRlJGPNUtyQM=;
	h=Date:From:To:Subject:From;
	b=hll1EMhCNQe9Mj1pDe/FeIZhYiNmunCfQtle/RX1hS5EIRZTcAOLSZFV7C17k/0bT
	 nyNgYHdiyk3yRZU5oyl7y7E9oiDA/dQO49QUb7K/jJw2/7EUqbqML5TbvirSV+tJKg
	 jw+ClArR1Lgk9dz7fY63RNEUSKtDDno8w4lXaxmrEIOLF6jD6KjVHLFasOElND5uVC
	 sR2hJJGM6n6yZA2daO9o9/e2WzJTzOc6U5UBAbjLeUVTu+gee007pygWUARaBi7qz5
	 /WfQsHuDqGqN1RZFPJSCJoIPBg1q0AlRt2McULknTT63zD/4ZmICfMcd/tsXdT3d+v
	 KELL1xqaZ8w5Q==
Date: Sun, 25 Jun 2023 19:30:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is closed
Message-ID: <20230625193059.328c25d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

v6.4 has been released and so the v6.5 merge window begins.
Please refrain from posting new features and code refactoring,
net-next is now closed.

