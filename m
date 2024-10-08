Return-Path: <netdev+bounces-133123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EB994FFC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BAF1C24CFD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D31DF99C;
	Tue,  8 Oct 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sci+9BO6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3E1DF98E;
	Tue,  8 Oct 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394234; cv=none; b=aXMHiaYtJNOyagWteZOQ99g7s5xY7LwK/Uxv8T4KJbhKl9om2uI84HyQU9ZoYkRxyk43CHULdfTRhFzs1WOjvs01pZCU27NAXemxJju0ImT6fMiIASVho2hBw/MpJoKbb1y3M+KbQMOF4qHZpcH5KhZK3IyU1cC/UhRtM5rfz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394234; c=relaxed/simple;
	bh=beV6SdRSwNqYllIoaIoTbiYyj61QRycYZIvCSA2a8MU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TUsh0S9qVuiOKh5nSXD83nod3yX+8sFvxIRqXRupAuuu0WF7wNacOPj111wByeCd1p1A/ZIL7nXajJzvcwsxUBHJzB40d4DELP9uDL9A0FpdoIdQPAx0pTfp+Y62RuI3eQ1JEV0xhcrP5hZs9xTHxxnMhuNbl3Zx/8Q0SqW+bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sci+9BO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CDEC4CED1;
	Tue,  8 Oct 2024 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394234;
	bh=beV6SdRSwNqYllIoaIoTbiYyj61QRycYZIvCSA2a8MU=;
	h=Date:From:To:Subject:From;
	b=Sci+9BO6jleKfv1QN/Q1K3i/7ohteTGd6JgBUchUJQEa2ACSfcFgUyUulIG+Ns6E/
	 tAkvxROmy01U+0rq+s3PBv8rBtm7AdyP3EsxH+AF1PRd66HMyiVUpx+WftEp1ocbpi
	 Ya2PrSVY+/Q3Yd36hZ/A31Nl5ndLNLwouLEq15uBqqbw7tsHbSfMAB8r/s788gmhbw
	 2MuYr/KJABrR0MzFNG/S0nbKv5eF2oQ+y6ELSjyJD+HEOOUY2/HlCGXCDb7vzXKrsG
	 S9MstNcAfYBloTNFBFXCVdOaXLCFuUJodkDy4fmKIwuveiERPKTCJEW7lHDu1Dp7bq
	 BNQAektON3zbA==
Date: Tue, 8 Oct 2024 06:30:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] no netdev call today
Message-ID: <20241008063033.301278c0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I don't think there's anything urgent to discuss, and my patch queue
is still quite long after recent vacation, so no call today :(

