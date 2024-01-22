Return-Path: <netdev+bounces-64737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F2836E4F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552A71F28B3B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02975DF2E;
	Mon, 22 Jan 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtm/6iTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D85EE76;
	Mon, 22 Jan 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943773; cv=none; b=AFVJaoiBmTuTpX+DwbBSSKrfwmjepcY7PNblYKL+HIjK4AB9LzQ7CPjYIY1DL5SivtU4bqyN+lJfareUeojP7WuRwRaL/y7hoWqmQ9hFHjq51RaLenXTve/e9S1VSjpYnTJvRNb9J/5HeW8A8/fXFfRSa1srg8nqzNtjptuuSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943773; c=relaxed/simple;
	bh=Bji7ZH3bmVt5SepqHNLp1DHXy4F+KSEnONE/lk0cHTo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VOrcMWNqrx7zVvwOrYXZPV/vCflGJusokleq3BJXG0/Ki6Fs1qxwMXO5N6ckjCye5f6I5Wd9QDKXop2GJMq1V50EoVzM4YBJJ7NOP+VnRlhDsgqHNnEtUxAT9ZMJR+bjb2L2XkfGMIsXjytoPRI/SGKk/2QSFF1XRpk1dLzE1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtm/6iTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397BEC433C7;
	Mon, 22 Jan 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943773;
	bh=Bji7ZH3bmVt5SepqHNLp1DHXy4F+KSEnONE/lk0cHTo=;
	h=Date:From:To:Subject:From;
	b=Vtm/6iTqPx0RFVtPFnTp8dW2L51QIWDdPUmZ1e0dKSaKVk9YLjkTC/ozUszq9Ze2T
	 JHFF0/dMJy9vfeNZDnQbRGb5AcpGQdldTyeUp321O4w7xqKmjR1A5TJcF9gT4+5wLu
	 qxoCIzpMsxgfRbs5gZPhXT84ZRS97I4zv7irVzgrIakjvM2vJqT8flz4jZ7W+j/6Aq
	 hZhAsUYQouJYePxqASEr0lDAjyT6sXTLt8VynFRw/XpjmE0g4TLIXGZ/wJn+8UNOmM
	 aI5w8bm2jC0YkfHKSKiBlJC21gMTe5LTYKN5TIW9e7nOOAuozqarwLyjWE1MYDzWRX
	 QMud6RZ2lU0yg==
Date: Mon, 22 Jan 2024 09:16:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] net-next is OPEN
Message-ID: <20240122091612.3f1a3e3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

net-next is open again, and accepting changes for v6.9.

Over the merge window I spent some time stringing together selftest
runner for netdev: https://netdev.bots.linux.dev/status.html
It is now connected to patchwork, meaning there should be a check
posted to each patch indicating whether selftests have passed or not.

If you authored any net or drivers/net selftests, please look around
and see if they are passing. If not - send patches or LMK what I need
to do to make them pass on the runner.. Make sure to scroll down to 
the "Not reporting to patchwork" section.

