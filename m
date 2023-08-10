Return-Path: <netdev+bounces-26508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD0777FB3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805C281C20
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39A21513;
	Thu, 10 Aug 2023 17:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFD20FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04745C433C7;
	Thu, 10 Aug 2023 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690333;
	bh=9xNnw9MlZHZXh+TQnt3n9ftd1NAsQ8YRcPHv37zvicU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy6mfQx+q8eginJvxvN+k8QTIk80WTJBIsBz+TRvxiiuwmRxTvz8b04/CpPP1LDdU
	 AKuJFDGch4wuE3Jp8Vu4+lfGkah5uYmPykwnfhoWJYmmpshBHUlJelXgeTGu7Dd51l
	 s4OTIX07ZWZfOCleyQvqY3rUOZ0yarjWDweq1Ik6A9GL2JHptciMMNsxMRQVOmYTbE
	 tVbSj7Ez2kx1+09yQX636Rw3rU0oBThUBCJlkTuRfdQwrRTme6nqLiIOQ+87JAYor0
	 aD01Ujngz/t7awtglLSKHNlwJkdjaIpS3aXHUy6k4AIo/yHfXrUXjsBt4kl1uOnKQH
	 FzqHvn78Og/UQ==
Date: Thu, 10 Aug 2023 19:58:48 +0200
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 6/6] selftests: tls: add rekey tests
Message-ID: <ZNUlWDvyOal1p5OY@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>

On Wed, Aug 09, 2023 at 02:58:55PM +0200, Sabrina Dubroca wrote:

nit: Ideally a patch description would go here.

> v2: add rekey_fail test (reject changing the version/cipher)
> v3: add rekey_peek_splice (suggested by Jakub)
>     add rekey+poll tests
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

...

