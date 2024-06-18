Return-Path: <netdev+bounces-104620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79B90D989
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1DE1F23A5C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E107764E;
	Tue, 18 Jun 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ifN/ebc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3D74070;
	Tue, 18 Jun 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728964; cv=none; b=UTXMRAWjBw1/vKFeSepa/gBt1UD5T/MmmYcTT1mil2UTlXLAevkWEdGl6uUKYRdO+qVWvik5SafQ90zoQ57dzJyzF1qM2IrKkH2KyjouUeMWKI2V/AFG5mt71rGLTIIrzo9IkNvXHzGylcAYzK84vwW8qOqQ/JaZOTOFTSeNzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728964; c=relaxed/simple;
	bh=vb9LUO9mKPOH1DjeuwESq/a3JXWFnuLS8evFmyQO3vI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z3tIRuCwun+rul/pMvfGyWDdLZgAUd7h8Jf1pXA24AalD3gc8zcJE+dKWRmMRdFR1ctX+qeytaSW8+ryvunWPMg8TEMFIW5gr13/ExqoprbwvhQ11IZmBi9T9N1+m5t6R9Exdt+kNkxMU7r2siWF/klrFDNutzbl9ZX2Lz5hKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ifN/ebc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB0AC3277B;
	Tue, 18 Jun 2024 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718728963;
	bh=vb9LUO9mKPOH1DjeuwESq/a3JXWFnuLS8evFmyQO3vI=;
	h=From:Subject:Date:To:Cc:From;
	b=2ifN/ebcXIc4lsWkct1D9/TQA87+8izEMYl5EQv2g2upfFU7FuS4chnQSDqZU5gF5
	 AKLMcpM696hqInNrKdGtY+cleBOk2/K0B0oddg+5kEO/fZM9dkE7THLhxAhlFRtyZL
	 j8BGJpX1OZp0G9oNlGXdTgucFul5NdnLAbnls0hs=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH 0/2] Documentation: update information for mailing lists
Date: Tue, 18 Jun 2024 12:42:09 -0400
Message-Id: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOG4cWYC/x3MQQqAIBBA0avErBvQKKmuEi1CJxsqCycikO6et
 HyL/xMIRSaBvkgQ6WbhI2TosgC7TMETssuGSlW1MrpFd1jBc7rsgrt4drhxWNF0Rqu6abQhBbk
 9I838/N9hfN8Pb1CcMGcAAAA=
To: Jonathan Corbet <corbet@lwn.net>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 ksummit@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=vb9LUO9mKPOH1DjeuwESq/a3JXWFnuLS8evFmyQO3vI=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNIKdzIETlnisaWn5cHZtA+Wt4+eLsqc/nvv//yDB3zeH
 5mZr9fv1lHKwiDGxSArpshSti92U1DhQw+59B5TmDmsTCBDGLg4BWAityMZ/tfcin5+rfHS1eeW
 cs6i66/5m4ZVTFpdf2lpa/H/T3d7tuoy/E9OuaDm4t7NylF/invbrJXF2auL886uKJ05ZV9USpb
 xA04A
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

There have been some important changes to the mailing lists hosted at
kernel.org, most importantly that vger.kernel.org was migrated from
majordomo+zmailer to mlmmj and is now being served from the unified
mailing list platform called "subspace" [1].

This series updates many links pointing at obsolete locations, but also
makes the following changes:

- drops the recommendation to use /r/ subpaths in lore.kernel.org links
(it has been unnecessary for a number of years)
- adds some detail on how to reference specific Link trailers from
inside the commit message

Some of these changes are the result of discussions on the ksummit
mailing list [2].

Link: https://subspace.kernel.org # [1]
Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat/ # [2]
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Konstantin Ryabitsev (2):
      Documentation: fix links to mailing list services
      Documentation: best practices for using Link trailers

 Documentation/process/2.Process.rst          |  8 ++++----
 Documentation/process/howto.rst              | 10 +++++-----
 Documentation/process/kernel-docs.rst        |  5 ++---
 Documentation/process/maintainer-netdev.rst  |  5 ++---
 Documentation/process/maintainer-tip.rst     | 24 ++++++++++++++++++------
 Documentation/process/submitting-patches.rst | 15 +++++----------
 6 files changed, 36 insertions(+), 31 deletions(-)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-docs-patch-msgid-link-6961045516e0

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>


