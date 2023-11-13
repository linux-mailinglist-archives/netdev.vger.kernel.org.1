Return-Path: <netdev+bounces-47396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F37EA144
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71B5B2079A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299481DA4D;
	Mon, 13 Nov 2023 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlAvLjc0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA1224CC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554E9C433C8
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699893015;
	bh=r1QgL5tkW62xUZ65eWuSkUpeb73uPbQ5viYg2TFBg1o=;
	h=Date:From:To:Subject:From;
	b=jlAvLjc06qmbGBH5EGg6U+HJdURXgmsBiUPVCo0eIwydw4IOwYZ2TXy/IVzBTaGtA
	 orzs4BHgooiP8pzkeZGkdjfUX4khp0CWKdLTV6/zVND6ZnJ/3LyS7PDFhABw0IhALM
	 heXoDRbQTqA1xuVOJU3pdw8QmccH/bwkXkJVAO4D+ERJS/cw2zcyqufPmQ4o68QJoq
	 yJueGn9mm51Zmu67yz5aPi0lHPsjPd6dHJ4TU7LS9Cn9os0ilq4jcGy1ylJC2o3rUu
	 /f64g8it/0FKfdRqeMCPHS4EV1VN9Ijh2tzSjHFfXxGV0v9eQqpR4ataBDN8iwDuZj
	 Ysf5oJrWM7PDA==
Date: Mon, 13 Nov 2023 11:30:13 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20231113113013.2ad9817c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

net-next is open again, and accepting changes for v6.8.

