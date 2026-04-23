Return-Path: <netdev+bounces-280608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G8zMxq56WlJigIAu9opvQ
	(envelope-from <netdev+bounces-280608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:15:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD544D758
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25ADF3018BF7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4C3C9EE8;
	Thu, 23 Apr 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGK5Lavt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD238F925;
	Thu, 23 Apr 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924899; cv=none; b=UVIlEhot0G3Dkl5/j2ONQrXsMxG2hT6VKblS+mIhPXiu2uiOIvwJ6vQ28+kMxRQAinNlTdMvcURxHedrFq0l/mpgtih6+W8hUMBMprV+qS3DHjWRLNP31TYLN5+cPHx4Jprg6vXzfhbMmTiqyd90lQvm2j9OjbQIPbqC5BqAVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924899; c=relaxed/simple;
	bh=BVlGZUVNmFIkrF146uqM9T7KD6940lkGZyHQcfuUUnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pzSnt2b+CBGr5Xfn5W8McfVIpZCXso+TvyC4EgDUQa9WQdZ0AshMwDZ8XoevNrNYoMcw1LXD+Oz62GrjQFymG0KlZ2tBPJTb0dLUAW6ZWdQgzzTimTX3DiDTfeTTljLIE6gn2BkqqwdRWhnplbgjmChxY0J6xugkwzWCcoYwldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGK5Lavt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924898; x=1808460898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BVlGZUVNmFIkrF146uqM9T7KD6940lkGZyHQcfuUUnM=;
  b=IGK5LavtVleerfqGm1x30tsmTUyKTaFIZD5u4DzDq+E2WqmOAg6HZmDD
   p9p7EQUugqZaEJRgmRn2LEjxEdOLjnWAmSukRs7eUKthHd/Kz+SOFpuLZ
   5A1xwI+bI8YSoogrNqT8Tw8pqsF93MaObyiXhjcI+17qz7b2d76ZYyMO0
   4byuqgoxg6knjsFZnqqAXAU0FYHXtK2lVthHP1a9rzYB1LRFpiXw+kB7d
   LKRsoEKefZVDJJNuzTKaoKsdAzIKaCJj1m4i/dT4gzdB3xkjmBqfLW3ym
   wa40OG5HSMAJ2BWS2GGJLI0UwNo6diOFYtKlBqbL8mXfxMOHD3plIpOYh
   Q==;
X-CSE-ConnectionGUID: 45JuQkj6TnaD28vGouHC0Q==
X-CSE-MsgGUID: txyRZ0mpSqeVNF1KXRqO5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76919225"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="76919225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:14:45 -0700
X-CSE-ConnectionGUID: vyjvMzK2RrKzypoQ9JVgjA==
X-CSE-MsgGUID: npqat2+cT4aHH/nKz2CITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="234353826"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:14:43 -0700
Date: Wed, 22 Apr 2026 23:14:43 -0700
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
Subject: [PATCH v11 00/12] VMSCAPE optimization for BHI variant
Message-ID: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAJG46WkC/3XSzWrDMAwH8FcpOc/Fkr+infYeYwfbclZDl5akC
 x2l7z6nbGtSvKME+sFf0qUZ05DT2DxvLs2QpjzmQ18KgKdNE3e+f08ic2k0KNFIAiumjzH6YxJ
 hFwQ71pbIuQ67pkwch9Tl8417fSv1Lo+nw/B10yeYuz8O6pUzgZCCvYFOJiCl+WWf+8/zNvent
 N/Gw0czaxP+CSDBrAUsAkEMzBSVJ1sX1EJAtxZUEYwjFdEonUjVBX0XAGgt6CKAZ886WWKOdcE
 sBFzvczKi5EC2NmlUQcq6YO8CSlgLdt6kBclswDjQdcH9ClaqxxSuCMFZ75zz1PquLrQL4fGab
 RFsG4JBHZQPVBfoLmiJa4Hma2oGGyKW9/onBcgFAY8vJYuROl9+zQefTCXH9Xr9BpX0NPkBAwA A
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 2EAD544D758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v11:
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
      kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
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
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20250916-vmscape-bhb-d7d469977f2f

Best regards,
--  
Thanks,
Pawan



