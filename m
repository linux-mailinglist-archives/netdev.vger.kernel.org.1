Return-Path: <netdev+bounces-33649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6A79F0B9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747A8281652
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C0A200B8;
	Wed, 13 Sep 2023 17:58:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FD1798E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 17:58:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B420619AF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694627926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pc0YBnnQvigZbTYj35NCXLikktn4/P6vHV3/P7dg5gE=;
	b=FgGJaADaPAU5/W3Wxim7txFMsVMGGBLoM1+grUKknK0jJkVNQEoJJdn9VpEoYzdOstsp+e
	u08+vUJnQe8gOTMYhQYAzq7qe/BW+gaJOezcG/0tWn8UP99YFEHdPfjlbFM02CFz9P+xmA
	BY4RPFzUXfdA3eGJNuzHZBBQCoK0x4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-mPs51VFUMHuNXnRqFL3sRA-1; Wed, 13 Sep 2023 13:58:41 -0400
X-MC-Unique: mPs51VFUMHuNXnRqFL3sRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10E7A811738;
	Wed, 13 Sep 2023 17:58:41 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AEA1F40C6EA8;
	Wed, 13 Sep 2023 17:58:38 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 0/2] configure: add support for color
Date: Wed, 13 Sep 2023 19:58:24 +0200
Message-ID: <cover.1694625043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

This series add support for the color parameter in iproute2 configure
script. The idea is to make it possible for iproute2 users and packagers
to set a default value for the color option different from the current
one, COLOR_OPT_NEVER, while maintaining the current default behaviour.

Patch 1 add the color option to the configure script. Users can set
three different values, never, auto and always, with the same meanings
they have for the -c / -color ip option. Default value is 'never', which
results in ip, tc and bridge to maintain their current output behaviour
(i.e. colorless output).

Patch 2 makes it possible for ip, tc and bridge to use the configured
value for color as their default color output.

Andrea Claudi (2):
  configure: add the --color option
  treewide: use configured value as the default color output

 Makefile        |  3 ++-
 bridge/bridge.c |  3 ++-
 configure       | 37 +++++++++++++++++++++++++++++++++++++
 ip/ip.c         |  2 +-
 tc/tc.c         |  2 +-
 5 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.41.0


