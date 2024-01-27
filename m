Return-Path: <netdev+bounces-66439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5283F1B7
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D0A281768
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24A200AA;
	Sat, 27 Jan 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeroconf.ee header.i=@zeroconf.ee header.b="BVnuAg+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873D1B80B
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397409; cv=none; b=YrbBtRpw+WC8jTQ4viBEac/E1ufKr5lm4kpHGt29TdsgfU7GPOkSFDZSz7nZ8uArYIwkAPISa8v5EM4J6Zz4I/v9F7aA2Uzt3YAdG/+Z4byJkjjhD1jz4be9iU2BEfN+APILxBphreJttXwjESbBy6ORAsp3FlXVw3TdUNTQDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397409; c=relaxed/simple;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=IOusNZ07ydIcNao4bRBH8BgfoQSA0U2BZI+UXjo4hqQHJX389Wx705Yn+ssyZB8NX7GTK53SaZM9MfE/gBeaT29eR/Zps1IuktXq50oqtSjnjxZcZSU0/jgNfG8jveFl8xGLgXfYCUQW8gdDqehsnV4r5ctyEXnZH1NZXqyzX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeroconf.ee; spf=pass smtp.mailfrom=zeroconf.ee; dkim=pass (2048-bit key) header.d=zeroconf.ee header.i=@zeroconf.ee header.b=BVnuAg+5; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeroconf.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeroconf.ee
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeroconf.ee;
	s=protonmail; t=1706397385; x=1706656585;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BVnuAg+51jYEofEfeayg+PsxW+uau5jnmOE7IS8K8nZvkMbonMlMXcBe+nTXWzDKS
	 Ug/bfv+tXmoVMccaFTEO1D8IqVknrc0/hTg9DW0YL/BoCHidSuQG+4T2vRO8NnhMRh
	 UfL8dZpzK9i86g9R8t+BsF5MebBFJGh57dRu+VtTIm/2AADClo4JBNnFwKIiY+7H1r
	 WvhlTGipflyPoZ7o1zBt1k6YfSznwtYl7N75UTJydWP29/rslFW0073cpuZ5v1kYM2
	 i1LsYs9F+N7UFKm+QUArbtmHbrE8BxT2VTlpniNCcRObkhrRUAHHDtKLNagGhtNYrk
	 aZp2W01qjizOA==
Date: Sat, 27 Jan 2024 23:16:03 +0000
To: netdev@vger.kernel.org
From: zeroconf <zeroconf@zeroconf.ee>
Subject: subscribe
Message-ID: <75b80506-ee2a-431e-8650-b0894ec60691@zeroconf.ee>
Feedback-ID: 45224067:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Empty Message

