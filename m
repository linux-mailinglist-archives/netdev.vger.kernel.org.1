Return-Path: <netdev+bounces-278310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKnlLuLn3WmulAkAu9opvQ
	(envelope-from <netdev+bounces-278310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433733F666C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEA79302BE66
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295335E95A;
	Tue, 14 Apr 2026 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWMZxDbo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5C35A925;
	Tue, 14 Apr 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150428; cv=none; b=r2hT2MoUrliPr6lLDfe6X75AvlqNpdGE4F0XItKWcumiIvBmjb9WqpKsAQQzMXPpSfUwgoMXgDcMaOqkl65ThZx3OGh6KhUtsdO8vMv7BxSfcwCK94nXbwfAh4o1A8ryQtWjXgjptv9eJIOGlwj6g5S+IZxi5trYnJdwyC8mfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150428; c=relaxed/simple;
	bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObpIU4IwfJdzbonjTgrTUfiJy52JxeX6yoxN+QZNkEfI+59IsIjN18MH0aql9au2CIYh6lct+Gf5IK0QnRvAsc16WdfnX3SMs06bt8zYqXxMG1U7XO/1dsSDj8I/S+LwH/DPsHnya9PQtkjBGiDLmfe6wEhmaIbtlhxI2edM7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWMZxDbo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776150428; x=1807686428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ru4xmAG5090zMTorvzBMO3CkMmXYAyYQWFiIdf/Og8c=;
  b=KWMZxDboe5ZZE8TD0yEhFVGtVXdInqzl5WXVx0txiXJsKtEdK5vlzZNr
   Zp71RSgF6m5VuPCSMD+/q3CsnfId/KyokoGT3pd0DN0HSpukB6woVW29+
   I77EVp1apG8YzPECuwM55OZsHmuZYx4xDcZmdfnkc5LuCXEPDb8Fv2DEf
   Lf+H/f96/1vgpfuyYjrAnreu5Nj4ib2TwQOSzL7IRYh8bmFoSOxSG7SuZ
   O8C4pVWZ2s1AoAezdIpoTiVaMylx/+4DbDUBaQpAy72YS++23Yh57iBq0
   g51ozkiFse6rSfdtlbMb2XOMprRWtBzy5U5+RvRNQ4+84El8JADJJNPDZ
   A==;
X-CSE-ConnectionGUID: 0rWqj1kMRUCSHfHUyrpRvg==
X-CSE-MsgGUID: Itpu1xHuS82Mxdf2iLi/qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77279725"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77279725"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:07:07 -0700
X-CSE-ConnectionGUID: B+lsJgTXQpCjAHLtvJHINg==
X-CSE-MsgGUID: Uoq8nSZtSuSIdJW7nhtEjg==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:07:05 -0700
Date: Tue, 14 Apr 2026 00:07:05 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v10 07/12] static_call: Add EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <20260414-vmscape-bhb-v10-7-efa924abae5f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 433733F666C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
restrict symbol visibility to only certain modules.

Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
set of modules to see and update the static key.

The immediate user is KVM, in the following commit.

checkpatch reported below warnings with this change that I believe don't
apply in this case:

  include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
  include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 include/linux/static_call.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..b610afd1ed55 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -216,6 +216,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -276,6 +279,9 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
@@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
+	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 

-- 
2.34.1



