Return-Path: <netdev+bounces-280781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Non4K9gw6mkCwwIAu9opvQ
	(envelope-from <netdev+bounces-280781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610E453D92
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82882301F17E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75C2F7AC1;
	Thu, 23 Apr 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n37nGt0U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104677F39;
	Thu, 23 Apr 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955603; cv=none; b=Iuukus4o0q15oF6CrmvjLUiJBZCmqGcBozfW/r38knuZtigUsfPDZ64H8cyyFGMmdxRhKe+tipwJpQnU85ptPQqT/QGbdzN7SuOXNhQkqtYnKRCZDBCOgG/Pl/wBaG5qQ+d06cPskWVru57EgmOOwVek5bJpgcXjqeRReusuArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955603; c=relaxed/simple;
	bh=3vy9o7HfDGoaToU61cCWVda460q9/2Qh/swmUMeL9OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwEvKTkVMxBWT5WfFmoNv09hF+ouVL0FbbeQrEAQQ33cQmG5OrWkK2jHdsvZjO1A4RMBPwhvo2GM/maJ9AkLhhC7tO3yYLVMBdfrzilXHaLitDCwwRPd2wlKPdleA9utljcOQdUqyU6Alc2f4Cgag3Livqt7fZK90fu0ck6TPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n37nGt0U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776955601; x=1808491601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3vy9o7HfDGoaToU61cCWVda460q9/2Qh/swmUMeL9OM=;
  b=n37nGt0UrJeSWG0xQ9DvIg/kqfkqQKXskNo+Q6Jx2pSovD6XuXq8Sy7X
   sLmD2ivwO0dOVAtsFrks0pwTy2/VvwyLUwGdn9eU3f/r0aVtDv9Nlge7i
   teACc111OeljQomF7vzYCBEcej6E6HUZTiVMwyIt4+qWOHnbilNNbiaxp
   T77DrfArJsNTmoc5pPF1F/C5XwIUz+mibhivRv6QgyxQ1JEuRZPFiYucZ
   wh4u+t9C85AEJi/K4RrNimUIksS+H++L9CcFAk6CZJJziq88/kpbTmvN8
   jPAmxH9VXVRxlz1co74WLDITpK9WD/YiEBTanoVzW5nKQqraiI0waB3jH
   w==;
X-CSE-ConnectionGUID: 853DUtztRLe0KVmpJvztdA==
X-CSE-MsgGUID: Y05vqM4jS8iehlHBp5djyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103387809"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="103387809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 07:46:41 -0700
X-CSE-ConnectionGUID: lJQQusUiTc+74cGl11/ByQ==
X-CSE-MsgGUID: HhZHMzHdQ+6vF4bYtaAzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="226149901"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 07:46:41 -0700
From: arjan@linux.intel.com
To: netdev@vger.kernel.org
Cc: anderson@allelesecurity.com,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jaltman@auristor.com,
	horms@kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [BUG] rxrpc: Client connection leak and BUG() call during kernel IO thread exit
Date: Thu, 23 Apr 2026 07:48:00 -0700
Message-ID: <20260423144801.292566-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPhRvkyZGKHRTBhV3P2PCCRxmRKGEvJQ0W5a9SMW3qwS2hp2Qw@mail.gmail.com>
References: <CAPhRvkyZGKHRTBhV3P2PCCRxmRKGEvJQ0W5a9SMW3qwS2hp2Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-280781-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 1610E453D92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arjan van de Ven <arjan@linux.intel.com>

This email is created by automation to help kernel developers deal
with a large volume of AI generated bug reports by decoding oopses
into more actionable information.


Decoded Backtrace

--- rxrpc_destroy_client_conn_ids (inlined into rxrpc_purge_client_connections)
    Source: net/rxrpc/conn_client.c

 54 static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 55 {
 56     struct rxrpc_connection *conn;
 57     int id;
 58
 59     if (!idr_is_empty(&local->conn_ids)) {
 60         idr_for_each_entry(&local->conn_ids, conn, id) {
 61             pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
 62                    conn, refcount_read(&conn->ref));
 63         }
 64         BUG();   // <- crash here
 65     }
 66
 67     idr_destroy(&local->conn_ids);
 68 }

--- rxrpc_destroy_local
    Source: net/rxrpc/local_object.c

420 void rxrpc_destroy_local(struct rxrpc_local *local)
421 {
422     struct socket *socket = local->socket;
423     struct rxrpc_net *rxnet = local->rxnet;
    ...
427     local->dead = true;
    ...
433     rxrpc_clean_up_local_conns(local);
434     rxrpc_service_connection_reaper(&rxnet->service_conn_reaper);
435     ASSERT(!local->service);
    ...
450     rxrpc_purge_queue(&local->rx_queue);
451     rxrpc_purge_client_connections(local);   // <- call here
452     page_frag_cache_drain(&local->tx_alloc);
453 }

--- rxrpc_io_thread
    Source: net/rxrpc/io_thread.c

554     if (!list_empty(&local->new_client_calls))
555         rxrpc_connect_client_calls(local);
    ...
569     if (should_stop)
570         break;
    ...
596     __set_current_state(TASK_RUNNING);
598     rxrpc_destroy_local(local);   // <- call here
601     return 0;


Tentative Analysis

The crash fires the unconditional BUG() at net/rxrpc/conn_client.c:64
because local->conn_ids is non-empty when rxrpc_destroy_local() is
called by the krxrpcio I/O thread during socket teardown.

When a client sendmsg() queues a call, the I/O thread picks it up via
rxrpc_connect_client_calls(). That function allocates a client
connection (rxrpc_alloc_client_connection()), registers it in the
local->conn_ids IDR with refcount=1, stores it in bundle->conns[], and
moves the call from new_client_calls to bundle->waiting_calls.

Once new_client_calls is empty and kthread_should_stop() is true, the
I/O thread exits its loop and calls rxrpc_destroy_local(). Inside that
function, rxrpc_clean_up_local_conns() iterates only the
local->idle_client_conns list. A connection that is in bundle->conns[]
but has never been activated on a channel (and thus never went idle) is
completely missed. rxrpc_purge_client_connections() then finds the
connection still registered in conn_ids and fires BUG().

The coverage gap was introduced by commit 9d35d880e0e4 ("rxrpc: Move
client call connection to the I/O thread"), which created a new
"allocated in bundle, not yet idle" state for connections that the
existing idle-list cleanup does not handle.

Note: fc9de52de38f ("rxrpc: Fix missing locking causing hanging calls"),
already present in 6.18.13, fixes a related missing-lock bug in the
same code area but does not address this idle-list coverage gap.


Potential Solution

rxrpc_clean_up_local_conns() should be extended to also release
connections stored in bundle->conns[] that have not yet appeared on
idle_client_conns. After the existing idle-list loop, the function
should iterate over all entries in local->client_bundles (the RB-tree
of active bundles), call rxrpc_unbundle_conn() on each occupied
bundle->conns[] slot, and put the connection. This ensures
rxrpc_destroy_client_conn_ids() always finds an empty IDR.


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/CAPhRvkyZGKHRTBhV3P2PCCRxmRKGEvJQ0W5a9SMW3qwS2hp2Qw/
Assisted-by: GitHub-Copilot:claude-sonnet-4.6 linux-kernel-oops-x86.

