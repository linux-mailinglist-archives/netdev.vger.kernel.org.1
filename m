Return-Path: <netdev+bounces-199032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E26ADEAC3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E517A05F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D772E88BD;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSGAy1pk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB32DE213;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=XD4RgyrHqXV/3xiyfnfh364M7HNIpVy/CSL7TjB5ZZQidyNm0Yr8Cop6oQUTZ15DVqz/3QrCkQc9wKk5r7LVlQ4lgBZXnwyx0kEbjs6SzlmK3hZ4P8bWyYJg/URvIUji9bK1BEz0EJIrMCIAOer3gE98UpnR1e9TLqibVQ5uQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=NWHr6s5MAHhaxWhvDkXosw3Qmf8A786TTZ4Xlu7HoGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv1hVjnkBH/0f1fWN5j2/Ko34OZGb2HSJHpa/m/j2lCHObi/2DbAcyR702F+PZrAOqZAk6D3guzxsepyn0232ZptDtCT9oLMsjRnqFjQSapi14p2s7tGgcKA4ssaNuKqFKfkcda+/pomKltiTcsAFJTzgD7FCRqbJJbX3Xs5ovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSGAy1pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F740C4CEF8;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=NWHr6s5MAHhaxWhvDkXosw3Qmf8A786TTZ4Xlu7HoGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSGAy1pkx0lHX7M1U4NRaQlSAbCks10vzCMZ3Lwp7jN7tTyI4o/o7ECCEHeJ1JMi5
	 7qUZYUs6JZWa3Ygd9xI7P2EO3duNcqsWgQTOZj74iyoyLMbsE8kK36B3yuXl6gNvzP
	 ToSW3nmFsiJs+JatBz4j+i2zJpMd26G0srbgHhKzjpdzW91puiAqGiAk9JRkhF46vc
	 XYai7lwOrfznU/s3N3yi9DYx9NDP00Kh2Nr5TYEoPA3lMdb9wrsNDImBd+1qjagtn/
	 ir2SNUyrhW6ITKNmdaEeMib51LbIUjaz7bT4aykffehjfTd2D41OWktI0b+uidPe3R
	 cGW7HRjZ+GHtQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036V2-3AR5;
	Wed, 18 Jun 2025 13:46:49 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 12/15] MAINTAINERS: add netlink_yml_parser.py to linux-doc
Date: Wed, 18 Jun 2025 13:46:39 +0200
Message-ID: <4077605f84d7ba6423dcb5fda4e96ac950856f1d.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The documentation build depends on the parsing code
at ynl_gen_rst.py. Ensure that changes to it will be c/c
to linux-doc ML and maintainers by adding an entry for
it. This way, if a change there would affect the build,
or the minimal version required for Python, doc developers
may know in advance.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..caa3425e5755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/net/ynl/pyynl/netlink_yml_parser.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
-- 
2.49.0


