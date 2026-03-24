Return-Path: <netdev+bounces-271225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBWaN0jVwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052A31A9CF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3A4C3067B3F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67737CD4F;
	Tue, 24 Mar 2026 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T759cUhU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10335959;
	Tue, 24 Mar 2026 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376184; cv=none; b=FcM5BHpS/jnnw8vvQPv2J1OkZNdrU/1zxPM3Y1mkdAXPceHWTNPZXlsbACLXb627rfrgSFrTlwx5YZnBiytQV7ZBcAjlOUawmTsro2mflOtMvVAx+k19es3AcOmImJSD/jbnzlEEHpavWSCDtpdZjuN2hKz5a8xl1Lap6q77iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376184; c=relaxed/simple;
	bh=YSwyPPq79cAEvrJLfHzNNBZ3q2KGHHXXEPrPyKjt0ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QssfRVk0sfc5Wj8xNL+Tt9NslQ67gA529pmyjxTYWRml+ZQJAxUgBnjRnfqrJnJqn3AV/reHzHsC6iFvcZY3RW1twO8XyYsC6s2NApNpuzd+FTS3VO1khgs13Qn6UmRmiSwH6nDFriX1WDOaL5+ir2Tai+IVkSDANUuFBGATmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T759cUhU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774376183; x=1805912183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YSwyPPq79cAEvrJLfHzNNBZ3q2KGHHXXEPrPyKjt0ZU=;
  b=T759cUhURt2tXzzzvra+9sqTOWuZ7AIXFX+FOA3Gak0xKU1KxRbNMjmV
   z5i7eDYIGIaPGwRQ9Irqxx/5lMxt8tpYxtHTQTsgk7fhIKsmu+3AHhfi2
   W7j/5t1ZPsERsVGYzDOJzSJtEJ5x/pA2Lhq5KX9hRz+At6gOoXoIQm/+3
   f45xKkv+x7l8WV2GEuCUNf+Nnh3SYatlr15+VJkJwNKcvJxbMgE6MX8z7
   uvow+bzoxXJ2BzcsN5yhIjoc1cT3fSZ11xdR67BCs+zktK6K09KrL8eOb
   7GcASehNYgJFaPtA0YY2bKXf63YJEvWu6maUqZMHxDo/px1xAu2WcDFel
   Q==;
X-CSE-ConnectionGUID: UUlz+JFARP6EVm2R9c+bGw==
X-CSE-MsgGUID: 0llXFwUKSVeOssAMLi8Xsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86879341"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86879341"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:16:22 -0700
X-CSE-ConnectionGUID: JmAcwus9QjyvwxJlVreAwg==
X-CSE-MsgGUID: qsSCmtJnS3i+D6YfLIgbcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="262362728"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:16:21 -0700
Date: Tue, 24 Mar 2026 11:16:21 -0700
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
Subject: [PATCH v8 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAJbUwmkC/23QTU7DMBAF4KtUXuPKM/6ZmhX3QCwcj0MttUmVF
 Kuoyt1xKqANZPlGmk967yrGNOQ0iufNVQyp5DH3XQ27p42I+9C9J5m5ZoEKrfLgZDmOMZySbPa
 NZGLjvCdqsRX14zSkNl9u2utbzfs8nvvh84YXmK/fDpqFU0AqycFCqxJ4bfjlkLuPyzZ353TYx
 v4oZq3grwAK7FLAKniIDbOPOni3LugHAWkp6CpY8jqi1SZ5vS6YuwDgl4KpAgQObJLzzHFdsA8
 CLvcsVtYeyM4lg7pRal1wdwEVLAU3L+lAMVuwBGZdoB/BKf23BVWhIReIKPhdaP8L0zR9AZECC
 fQ4AgAA
X-Change-ID: 20250916-vmscape-bhb-d7d469977f2f
X-Mailer: b4 0.15-dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6052A31A9CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v8:
- Use helper in KVM to convey the mitigation status. (PeterZ/Borisov)
- Fix the documentation for default vmscape mitigation. (BPF bot)
- Remove the stray lines in bug.c (BPF bot).
- Updated commit messages and comments.
- Rebased to v7.0-rc5.

v7: https://lore.kernel.org/r/20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com
- s/This allows/Allow/ and s/This does adds/This adds/ in patch 1/10 commit
  message (Borislav).
- Minimize register usage in BHB clearing seq. (David Laight)
  - Instead of separate ecx/eax counters, use al/ah.
  - Adjust the alignment of RET due to register size change.
  - save/restore rax in the seq itself.
  - Remove the save/restore of rax/rcx for BPF callers.
- Rename clear_bhb_loop() to clear_bhb_loop_nofence() to make it
  obvious that the LFENCE is not part of the sequence (Borislav).
- Fix Kconfig: s/select/depends on/ HAVE_STATIC_CALL (PeterZ).
- Rebased to v7.0-rc4.

v6: https://lore.kernel.org/r/20251201-vmscape-bhb-v6-0-d610dd515714@linux.intel.com
- Remove semicolon at the end of asm in ALTERNATIVE (Uros).
- Fix build warning in vmscape_select_mitigation() (LKP).
- Rebased to v6.18.

v5: https://lore.kernel.org/r/20251126-vmscape-bhb-v5-2-02d66e423b00@linux.intel.com
- For BHI seq, limit runtime-patching to loop counts only (Dave).
  Dropped 2 patches that moved the BHB seq to a macro.
- Remove redundant switch cases in vmscape_select_mitigation() (Nikolay).
- Improve commit message (Nikolay).
- Collected tags.

v4: https://lore.kernel.org/r/20251119-vmscape-bhb-v4-0-1adad4e69ddc@linux.intel.com
- Move LFENCE to the callsite, out of clear_bhb_loop(). (Dave)
- Make clear_bhb_loop() work for larger BHB. (Dave)
  This now uses hardware enumeration to determine the BHB size to clear.
- Use write_ibpb() instead of indirect_branch_prediction_barrier() when
  IBPB is known to be available. (Dave)
- Use static_call() to simplify mitigation at exit-to-userspace. (Dave)
- Refactor vmscape_select_mitigation(). (Dave)
- Fix vmscape=on which was wrongly behaving as AUTO. (Dave)
- Split the patches. (Dave)
  - Patch 1-4 prepares for making the sequence flexible for VMSCAPE use.
  - Patch 5 trivial rename of variable.
  - Patch 6-8 prepares for deploying BHB mitigation for VMSCAPE.
  - Patch 9 deploys the mitigation.
  - Patch 10-11 fixes ON Vs AUTO mode.

v3: https://lore.kernel.org/r/20251027-vmscape-bhb-v3-0-5793c2534e93@linux.intel.com
- s/x86_pred_flush_pending/x86_predictor_flush_exit_to_user/ (Sean).
- Removed IBPB & BHB-clear mutual exclusion at exit-to-userspace.
- Collected tags.

v2: https://lore.kernel.org/r/20251015-vmscape-bhb-v2-0-91cbdd9c3a96@linux.intel.com
- Added check for IBPB feature in vmscape_select_mitigation(). (David)
- s/vmscape=auto/vmscape=on/ (David)
- Added patch to remove LFENCE from VMSCAPE BHB-clear sequence.
- Rebased to v6.18-rc1.

v1: https://lore.kernel.org/r/20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com

Hi All,

These patches aim to improve the performance of a recent mitigation for
VMSCAPE[1] vulnerability. This improvement is relevant for BHI variant of
VMSCAPE that affect Alder Lake and newer processors.

The current mitigation approach uses IBPB on kvm-exit-to-userspace for all
affected range of CPUs. This is an overkill for CPUs that are only affected
by the BHI variant. On such CPUs clearing the branch history is sufficient
for VMSCAPE, and also more apt as the underlying issue is due to poisoned
branch history.

Below is the iPerf data for transfer between guest and host, comparing IBPB
and BHB-clear mitigation. BHB-clear shows performance improvement over IBPB
in most cases.

Platform: Emerald Rapids
Baseline: vmscape=off
Target: IBPB at VMexit-to-userspace Vs the new BHB-clear at
	VMexit-to-userspace mitigation (both compared against baseline).

(pN = N parallel connections)

| iPerf user-net | IBPB    | BHB Clear |
|----------------|---------|-----------|
| UDP 1-vCPU_p1  | -12.5%  |   1.3%    |
| TCP 1-vCPU_p1  | -10.4%  |  -1.5%    |
| TCP 1-vCPU_p1  | -7.5%   |  -3.0%    |
| UDP 4-vCPU_p16 | -3.7%   |  -3.7%    |
| TCP 4-vCPU_p4  | -2.9%   |  -1.4%    |
| UDP 4-vCPU_p4  | -0.6%   |   0.0%    |
| TCP 4-vCPU_p4  |  3.5%   |   0.0%    |

| iPerf bridge-net | IBPB    | BHB Clear |
|------------------|---------|-----------|
| UDP 1-vCPU_p1    | -9.4%   |  -0.4%    |
| TCP 1-vCPU_p1    | -3.9%   |  -0.5%    |
| UDP 4-vCPU_p16   | -2.2%   |  -3.8%    |
| TCP 4-vCPU_p4    | -1.0%   |  -1.0%    |
| TCP 4-vCPU_p4    |  0.5%   |   0.5%    |
| UDP 4-vCPU_p4    |  0.0%   |   0.9%    |
| TCP 1-vCPU_p1    |  0.0%   |   0.9%    |

| iPerf vhost-net | IBPB    | BHB Clear |
|-----------------|---------|-----------|
| UDP 1-vCPU_p1   | -4.3%   |   1.0%    |
| TCP 1-vCPU_p1   | -3.8%   |  -0.5%    |
| TCP 1-vCPU_p1   | -2.7%   |  -0.7%    |
| UDP 4-vCPU_p16  | -0.7%   |  -2.2%    |
| TCP 4-vCPU_p4   | -0.4%   |   0.8%    |
| UDP 4-vCPU_p4   |  0.4%   |  -0.7%    |
| TCP 4-vCPU_p4   |  0.0%   |   0.6%    |

[1] https://comsec.ethz.ch/research/microarch/vmscape-exposing-and-exploiting-incomplete-branch-predictor-isolation-in-cloud-environments/

---
Pawan Gupta (10):
      x86/bhi: x86/vmscape: Move LFENCE out of clear_bhb_loop()
      x86/bhi: Make clear_bhb_loop() effective on newer CPUs
      x86/bhi: Rename clear_bhb_loop() to clear_bhb_loop_nofence()
      x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
      x86/vmscape: Move mitigation selection to a switch()
      x86/vmscape: Use write_ibpb() instead of indirect_branch_prediction_barrier()
      x86/vmscape: Use static_call() for predictor flush
      x86/vmscape: Deploy BHB clearing mitigation
      x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
      x86/vmscape: Add cmdline vmscape=on to override attack vector controls

 Documentation/admin-guide/hw-vuln/vmscape.rst   | 15 ++++-
 Documentation/admin-guide/kernel-parameters.txt |  6 +-
 arch/x86/Kconfig                                |  1 +
 arch/x86/entry/entry_64.S                       | 34 +++++++----
 arch/x86/include/asm/cpufeatures.h              |  2 +-
 arch/x86/include/asm/entry-common.h             |  9 ++-
 arch/x86/include/asm/nospec-branch.h            | 13 +++--
 arch/x86/include/asm/processor.h                |  1 +
 arch/x86/kernel/cpu/bugs.c                      | 76 ++++++++++++++++++++-----
 arch/x86/kvm/x86.c                              |  4 +-
 arch/x86/net/bpf_jit_comp.c                     | 11 +---
 11 files changed, 127 insertions(+), 45 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20250916-vmscape-bhb-d7d469977f2f

Best regards,
--  
Thanks,
Pawan



