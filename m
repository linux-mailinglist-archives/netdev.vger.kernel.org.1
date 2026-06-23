Return-Path: <netdev+bounces-301421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yfd9NzvDOmqoGAgAu9opvQ
	(envelope-from <netdev+bounces-301421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA76B913B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:32:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ROAF8xjh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301421-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B68AB303B1A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE803890F8;
	Tue, 23 Jun 2026 17:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A634753A;
	Tue, 23 Jun 2026 17:32:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235960; cv=none; b=qilooguOFYEw3ezoSVnTEcfLaWl9VlwnDIsWo5DmPC7wYP98wI1qT3MATn5haAmivW6e2VxnMW2uRZ34M9j8WzY1OzwrwP4fOx6Z9Yc+627r3zkxDuY+8nX67u8Bic7BhyiKvpXsl9TRPeSoah16aRf7og/DQRwxmDzzr9CAqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235960; c=relaxed/simple;
	bh=EaXUBP6Fus11Qnb7LZg/aF3HHSEsKAT0/awbcaYgXBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bjqxfE6Cjw5hKUJdHzVW4r0jBuD+0t5x4r6bNMJ+wZfBKSDRW1seMfyC7Gvw74bYv8k23Zd0pMyePwdwKxELY9NmNqPviQVYKCOr/JoMiWgJNmw3OkvRSAawpzBwHtwxOCxm1TnfvLR4oN7/85op1wM31yTH0aHpAopq0dEp2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROAF8xjh; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782235958; x=1813771958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EaXUBP6Fus11Qnb7LZg/aF3HHSEsKAT0/awbcaYgXBk=;
  b=ROAF8xjhkKfAMo9RAZroEVCYnh7wSbsMh+f4gUoRcslA+QjFeRiAZhZX
   2F8BljZbQIcTagEWUJCF52CvALEHGpaGLsF/DtZ06UJJ8NeLtmLUtya2n
   saBF3DTCSBHgbYU1B4j4unwGE6clol8a6YdERKExUDzQGNjqssHuNQbcG
   /Va0gjOWk7CCGomOVZxQpCpyKLuy2tTHQ615fxIBSVpQKJzPUvcOOoN+g
   Tq/KHUtxWJL1K41gRl0NCOOqPAeYCNNB2BCDzGw+V7liUIqc1SC2iO9HT
   PSklMYTX8Tyc7tMGVwlsysRvj8JTDJMn4b9ENK6p8+Bcx0m/ynzcnO4CX
   Q==;
X-CSE-ConnectionGUID: zK2uSsThQ0iUlUPCf9DlaA==
X-CSE-MsgGUID: xdlVyD/OR4WDxQl+qcRq9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100538715"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100538715"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:32:37 -0700
X-CSE-ConnectionGUID: HxFBj3SXTf670benaEflbQ==
X-CSE-MsgGUID: sSTU+2ntTtaz6yVM4DxKQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273646411"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:32:36 -0700
Date: Tue, 23 Jun 2026 10:32:36 -0700
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v12 00/12] VMSCAPE optimization for BHI variant
Message-ID: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAFyvOWoC/3XSS27CMBAG4KugrGvkGb/irnqPqgvbYxdLEFBCI
 yrE3eugtiSRWXokf5rHf22G2Oc4NK+ba9PHMQ/52JUH4MumCTvXfUaWqRQa5Ki4Bc3GwxDcKTK
 /84wMSW2tMQlTU36c+pjy5c69f5T3Lg/nY/9910eYqr8OyoUzAuOMnILEI1gh6W2fu6/LNnfnu
 N+G46GZtBH/BeCglgIWwULwRDYIZ3VdEDMBzVIQRVDGioBKyGhFXZAPAcAuBVkEcORIRm2JQl1
 QMwGX+xwVK3MgaR0lCs95XdAPATksBT1tUgMnUqAMyLpg/gTNxXoKUwRvtDPGONu6VBfambC+Z
 lsE3XqvUHrhvK0L9iFIjkvBTteUBNoHLPF6MgXwGQHrSPFixORK1px3UT2ZA2Bm4KoNmHLpoY0
 8JIEuVfq43W4/yqDU0kUDAAA=
X-Change-ID: 20250916-vmscape-bhb-d7d469977f2f
X-Mailer: b4 0.16-dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301421-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:
 lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,ethz.ch:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49BA76B913B

v12:
- Applied tags from Sean and Borisov.
- Rebased to v7.1

It would be nice to have some more review-tags to help this get merged
sooner. If you have already reviewed v11 this version should be easy, it is
mostly a rebase.

v11: https://lore.kernel.org/r/20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com
- Use ifdef EXPORT_SYMBOL_FOR_KVM guard for EXPORT_STATIC_CALL_FOR_KVM()
  definition. It is not practical to define one but not the other. (Sean)
- Collected tags.

v10: https://lore.kernel.org/r/20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com
- Add patches to define EXPORT_STATIC_CALL_FOR_MODULES() and
  EXPORT_STATIC_CALL_FOR_KVM(), so that vmscape_predictor_flush static key
  is only accessible to KVM and not to other kernel modules. (PeterZ)
  (Borisov earlier objected to exporting the static key to all modules, but
  now the static key is only exported to KVM. I guess that resolves the
  concern.)
- Avoid an explicit call to vmscape_mitigation_enabled() and instead use
  static_call_query() in VMexit hot path. (Sean)
- Drop vmscape_mitigation_enabled(), as it is no longer needed.
- Rebased to v7.0

v9: https://lore.kernel.org/r/20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com
- Use global variables for BHB loop counters instead of ALTERNATIVE-based
  approach. (Dave & others)
- Use 32-bit registers (%eax/%ecx) for loop counters, loaded via movzbl
  from 8-bit globals. 8-bit registers (e.g. %ah in the inner loop) caused
  performance regression on certain CPUs due to partial-register stalls. (David Laight)
- Let BPF save/restore %rax/%rcx as in the original implementation, since
  it is the only caller that needs these registers preserved across the
  BHB clearing sequence.
- Drop Reviewed-by from patch 2/10 as the implementation changed significantly.
- Apply Tested-by from Jon Kohler to the series (except patch 2/10).
- Fix commit message grammar. (Borislav)
- Rebased to v7.0-rc6.

v8: https://lore.kernel.org/r/20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com
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
Pawan Gupta (12):
      x86/bhi: x86/vmscape: Move LFENCE out of clear_bhb_loop()
      x86/bhi: Make clear_bhb_loop() effective on newer CPUs
      x86/bhi: Rename clear_bhb_loop() to clear_bhb_loop_nofence()
      x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
      x86/vmscape: Move mitigation selection to a switch()
      x86/vmscape: Use write_ibpb() instead of indirect_branch_prediction_barrier()
      static_call: Define EXPORT_STATIC_CALL_FOR_MODULES()
      KVM: Define EXPORT_STATIC_CALL_FOR_KVM()
      x86/vmscape: Use static_call() for predictor flush
      x86/vmscape: Deploy BHB clearing mitigation
      x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
      x86/vmscape: Add cmdline vmscape=on to override attack vector controls

 Documentation/admin-guide/hw-vuln/vmscape.rst   | 15 ++++-
 Documentation/admin-guide/kernel-parameters.txt |  6 +-
 arch/x86/Kconfig                                |  1 +
 arch/x86/entry/entry_64.S                       | 21 ++++---
 arch/x86/include/asm/cpufeatures.h              |  2 +-
 arch/x86/include/asm/entry-common.h             | 13 ++--
 arch/x86/include/asm/kvm_types.h                |  1 +
 arch/x86/include/asm/nospec-branch.h            | 15 +++--
 arch/x86/kernel/cpu/bugs.c                      | 84 +++++++++++++++++++++----
 arch/x86/kvm/x86.c                              |  4 +-
 arch/x86/net/bpf_jit_comp.c                     |  4 +-
 include/linux/kvm_types.h                       | 10 ++-
 include/linux/static_call.h                     |  8 +++
 13 files changed, 147 insertions(+), 37 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20250916-vmscape-bhb-d7d469977f2f

Best regards,
--  
Pawan



