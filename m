Return-Path: <netdev+bounces-195030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C176CACD88C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5461B3A39D1
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39F1A2C04;
	Wed,  4 Jun 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXeeAwan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37810A937
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022065; cv=none; b=VG1IJDscIhDbagm55+uaA/qiamEm7x2qJtbY5ODESRMR/k9gJRLy+zURdgOa6TkGrJCnvk+hiHidWrgJu802NitvxvykGfMNjSZHdukfvwYKonVw7LiLIWiMYgi8QEyTEhVA6gmaxOBmjyDOdSpcv+fUrdPJcZwYIaFPaau+v4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022065; c=relaxed/simple;
	bh=OsQIRzjl5j5TT8wFfjAxaB/teJq3HkttubqF/2JV72w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjsHR9lxG8izVwuVAybTvIhdksnTh03ewoJHLp96r4xKcM1nQtPCs1hzixuMceZS/ya5yPKd2Mn7pvISZpuLXcK/MhfrAkee8ZT2o4KCwIysJd4AnaFjdNMNjjHYN8Bjd9LDIUt4uOulCW8THYPKkXU13rUrGEEfZ1R1UXkftYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXeeAwan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB99CC4CEE7;
	Wed,  4 Jun 2025 07:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022063;
	bh=OsQIRzjl5j5TT8wFfjAxaB/teJq3HkttubqF/2JV72w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXeeAwan7gaVuKLwbbxpDHSQNNcbPxXDjwJ6TpFd90JmzS8E8IqeomqUR0Ta5WbEE
	 8ppH5G8YhPzeIeO/olRX/iyD0g2yQkDvS7xjg9XBrKhbNxAc7akWIAb4a88rebpvt3
	 ZI88JtdSyvtOQ66MnvQFhnWbQIYw8PN4EdAYRQ5FlvLN3Z/oIyMn/tcM0bBGKmdNvQ
	 HZTafLLVcSwuDZQ3tsf76Qvk6yGGqYHewedb0YXrcyzsI+fjX3FIABogadPlIKu5GB
	 jP109q9qXoiQ23FV5qHPi+LXVc2nEg0tql94zQAY5PmN+9zGpI6uOdLoJc1kbXRcFF
	 A/9g1exnFT9Ww==
Date: Wed, 4 Jun 2025 08:27:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [ANN] pylint and shellcheck
Message-ID: <20250604072740.GB1675772@horms.kernel.org>
References: <20250603120639.3587f469@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603120639.3587f469@kernel.org>

On Tue, Jun 03, 2025 at 12:06:39PM -0700, Jakub Kicinski wrote:
> Hi!
> 
> It's merge window time so I have a bit of time to catch up on random
> things. I added shellcheck, yamllint and pylint:
> https://github.com/linux-netdev/nipa/commit/c0fe53ae533d19c19d2e00955403fb57c3679084
> https://github.com/linux-netdev/nipa/commit/255ee0295a096ee7096bebd9d640388acc590da0
> https://github.com/linux-netdev/nipa/commit/54e060c9094e33bffe356b5d3e25853e22235d49
> to the netdev patchwork checks.
> 
> They will likely be pretty noisy so please take them with a grain of
> salt (pretty much like checkpatch). Using the NIPA scripts from the
> commits above could be useful to find the delta of new warnings, since
> there will be quite a few existing ones.
> 
> I suspect as we get more experience we will find the warning types to
> disable, and we will drive the number of existing errors down to make
> checking for new ones less of a pain. As I said, for now please don't
> take these checks failing at face value.

Thanks Jakub,

I agree this is a good step.

Anecdotally, my feeling from running shellcheck over patches for a little
while now is that the feedback it gives mainly relates to stricter coding
practices which aren't generally followed. And yet the scripts seem to run
reliably in the environments they are intended to run in.

So I'll be interested to see if we end up go for some mix of disabling
warnings and updating (creating!) our preferred coding style for shell
scripts.

</2c>


