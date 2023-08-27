Return-Path: <netdev+bounces-30912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DC789CD3
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968542811B6
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC17612D;
	Sun, 27 Aug 2023 09:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A617E4
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 09:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C49C433C7;
	Sun, 27 Aug 2023 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693129789;
	bh=NN4bF4fY8JwEW6Rjtb55IoHjAtxKuNE9Mm+BDXzOo6Q=;
	h=Date:From:Subject:To:Cc:From;
	b=PUi/coDWWpt1mY/QF4ajF04B91ZqcHkucBS9QGzMcAvoqkhSwIrZ8GIzCWpLYa9EU
	 mTo6bMUEa6skFnCrOUa+kZJNb38u7wwvGqtGbNv2DU+C6YYMiObsFBgPEiN+K1B/T2
	 zDKawLrcgiMg3JSrTvkm14K3rvv3A78kD2wLL3tpwsd+eiWOD7P1gkjNLdD/60zWPR
	 N2FZGK9RZxhFzxiOyYYFivd2kEXCxbN3Qk4qITlw0V/RIX9UykvdMqy4dWVCZiW8Vt
	 ThcVIfTLzED66YBR5TauRFGHVHOdugFcxLAxBoqVOfSi2+xCnCz/v2PUghuim9koR6
	 2/htvfK27ZgHw==
Message-ID: <3929a597-6a83-ed30-ad15-9e4404373374@kernel.org>
Date: Sun, 27 Aug 2023 11:49:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [NFC/neard] neard release v0.19
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, aur-general@lists.archlinux.org,
 devel@lists.fedoraproject.org, packaging@lists.opensuse.org
Cc: Mark Greer <mgreer@animalcreek.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Cody P Schafer <dev@codyps.com>,
 Dirk Mueller <dmueller@suse.com>, kokakiwi@kokakiwi.net,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

v0.19
=====
This is announce of new release of neard, an user-space counterpart of
Linux kernel NFC stack, v0.19.

I am sending this email to few distro lists and folks involved in
packaging neard (and updating existing packages). Please let me know if
I should skip notifying you or you think I should Cc someone else.

The release includes few fixes. Full changelog via Git, simplified changelog in:
https://git.kernel.org/pub/scm/network/nfc/neard.git/tree/ChangeLog?h=v0.19

Source code release:
https://git.kernel.org/pub/scm/network/nfc/neard.git/tag/?h=v0.19
https://git.kernel.org/pub/scm/network/nfc/neard.git/snapshot/neard-0.19.tar.gz

Best regards,
Krzysztof

