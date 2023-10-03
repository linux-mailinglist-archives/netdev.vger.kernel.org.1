Return-Path: <netdev+bounces-37727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E287B6D39
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5CA241C203AB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075736AF0;
	Tue,  3 Oct 2023 15:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A5FBF3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D2AC433C7;
	Tue,  3 Oct 2023 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347272;
	bh=qRje/Pk5Vlz0WeT72pvKg6Iy3QGu/zJk5IQS8S7hZs0=;
	h=From:To:Cc:Subject:Date:From;
	b=J8ywgIzzmGX4ScM+H+0KkCyMk9dP9lGNLf996WSlk8fPVehZxQs0OGLhuECu63H6O
	 c34PdqKdi+r9dleLNULDfnQ7KELnCRXxhyZry3J65t+xUPY52wbWt4T1Oz9wDQDzXB
	 VUFbF2KaEZCLm1Tl/Cl6LSj3YIy5I5fOrwl55QWQqWlb2WEaKFXJxUI3fJq8CBaa7G
	 Qb21hwBUDtkAJ64Y5KTQo/UU7HUrJAAKpQ37Kome9I++KdFpYRG6/nf5fHEtyka727
	 VMkseUykQlWktFgs6oFhtQP0o9NiMWFsRTBYlai2P1Urx4RXft40YKyityY5ImD/zP
	 z+EWCtOUirgUg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@google.com,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] ynl Makefile cleanup
Date: Tue,  3 Oct 2023 08:34:13 -0700
Message-ID: <20231003153416.2479808-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While catching up on recent changes I noticed unexpected
changes to Makefiles in YNL. Indeed they were not working
as intended but the fixes put in place were not what I had
in mind :)

Jakub Kicinski (3):
  ynl: netdev: drop unnecessary enum-as-flags
  tools: ynl: don't regen on every make
  tools: ynl: use uAPI include magic for samples

 Documentation/netlink/specs/netdev.yaml | 2 --
 tools/net/ynl/Makefile                  | 1 -
 tools/net/ynl/generated/Makefile        | 2 +-
 tools/net/ynl/samples/Makefile          | 5 ++++-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0


