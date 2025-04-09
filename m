Return-Path: <netdev+bounces-180598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B31A81C1D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264F242493D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AD1DA0E0;
	Wed,  9 Apr 2025 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3w4ezDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353F1624CC;
	Wed,  9 Apr 2025 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176621; cv=none; b=olIWavNu482SoFRhHl8QApNj2HBfZ5L/3ID1cg0Z5fzLxrZIDReX9rPbmEpmHYVJ8BrnEPzGOR4N8WRPTGRtDnK7ovviWgMnJbf2wj03LPse447EbhBnYAHRfWGFxjF78qgjw+2VgHh6EIMTGd7QFXlBs19eAOXPhi0h1yhLJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176621; c=relaxed/simple;
	bh=Pkxu3NAMTKZQhUI6l0kj/7Y9JPAUk8WU77HBxyZyuu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAMdWa4oGPkduXfzIySmDLCBZUojamL2ELos/xM4NPNa9wVQcsYsjNUuq/GF/7bDbaXQJ8vjXC8ocqAEn76TlLX/HtFmxTILltecEkw4MsPnbcLl/u6toZIsVM58+H/ld7mW48AMojCiCZejTKnXO9/v91lUzoHWH+QlE4knVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3w4ezDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D5AC4CEE3;
	Wed,  9 Apr 2025 05:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744176620;
	bh=Pkxu3NAMTKZQhUI6l0kj/7Y9JPAUk8WU77HBxyZyuu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3w4ezDP78cfE/iZLUPQSN5v7+y2H4QHQ7UbBV102hyMUwGl0LJLPZG9CyarY9/Cf
	 9INMXu2KVvX4QfwG+/aZnh8iOHChqPu4WMWSK5DiHL41kdBmZkDaOT0Vl073h1ldb1
	 vycANWuTqhJ9ijQAIIxwe4dHV7cRc4a+bMlkWbxlomrNyVMmeoZ9sqsQpfQUT+BaLK
	 pRBSb2IxcS2rpJhFMEdc2vuUYEMpSfKpdjWzdfl5JpV1EO5+RyN2Y16aOf/ewfLqdJ
	 JFvwcKyAhnn8iN3JgiPGWS8oNawi6RwRHYWVClW+VbSr95Qts8KRAsxolRFUjJES+J
	 0q/shjDlWH82A==
Date: Wed, 9 Apr 2025 13:29:55 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <20250409132955.04248d25@sal.lan>
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Jon,

Em Tue,  8 Apr 2025 18:09:03 +0800
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Mauro Carvalho Chehab (32):
>   scripts/kernel-doc: rename it to scripts/kernel-doc.pl
>   scripts/kernel-doc: add a symlink to the Perl version of kernel-doc

Forgot to mention at the description. After review, it makes sense to merge
those two patches into one.

Having them in separate is good for review, but merging them makes
sense from bisectability PoV.

Regards,
Mauro

