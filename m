Return-Path: <netdev+bounces-41217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7397CA43F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF41B207E9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2781CAAA;
	Mon, 16 Oct 2023 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dSdU97xz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F21CA8C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:04 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CB97
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0f945893so36301146d6.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448959; x=1698053759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+yKPj7W02pHqyof17JshTumPOHcMAiGNuBZM3pdmSY=;
        b=dSdU97xzUzobhjW9rZuaziEILwgiBVI8hVza3kD2E7Zq4gwhn43o3T8ZCtjUAsFwWY
         9TMakbUXkav8rFWNPIy41q9al4gEwlPSjBtyxU7Mwos7Eex066Pln3+Scoc/lx90LFUR
         wfNt2KVIpryiFsPztdhzkk4eLecXbjHJj95HY7cU/tzfqjetn0hRQxVN8hEFi16nz3CZ
         S9kasInwvZEZg+8bsmWwY4hinA4lG+wTFZ+NhLyuJ5+VCUqGuc2xSih5BM8F02aWdOHZ
         HF7BznaeqXE6c25+5bu6GsMd1s2WuoGoXFOM/ISYwYP5pD87fhDwtnGUNvJ6mjdmWBzI
         mQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448959; x=1698053759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+yKPj7W02pHqyof17JshTumPOHcMAiGNuBZM3pdmSY=;
        b=db74ORTBd11yNIp7dwWKbdrQnYYZxpw4p+FIvQw2PO/czypvbdjEJJnjjVg56T8YYF
         BEy+rfMRRYt53zp7YqZ8U68OBp683c9l4awpInjQ7d4Sy+5cw5PPT+0MTpT0Bc6x5y2A
         36uB5XXLqVs4IBtSrTDVT61FA+90M96FtHE6lnCy6aOoB8Ri4jg4NRNmK0lLKNMiUSJV
         VKsYNL0JfedmdiuEYrTSqbOYwI/d1QoJvD0W2l9+flRaGFO7Cm/8eqVsXtt7yTvdTNOQ
         EpWuoCI5lnUmllOF7vZDn8pqlVz0RgEDwcwn7Le8AqfwpfLjS6s2xzmN7bDowi+vVm64
         ACJA==
X-Gm-Message-State: AOJu0Yxtak4m1+am/9dQyHiNGGUqVrDh5CYI0rS9GC9/A5VRUL/qA7Ys
	j5Zi+rKA79svtS+DX/l2Jz64FhNq4bxtqBRTxiA=
X-Google-Smtp-Source: AGHT+IHwk2MUzqELug+TE9n17760LB62KhphEO7WC46LlHLGkIU3g3mZIBCwWmhQqQO6Xm2HRrCheg==
X-Received: by 2002:a05:6214:2462:b0:65a:f7b2:2057 with SMTP id im2-20020a056214246200b0065af7b22057mr12407439qvb.24.1697448958939;
        Mon, 16 Oct 2023 02:35:58 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:35:58 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	deb.chatterjee@intel.com,
	john.andy.fingerhut@intel.com,
	dan.daly@intel.com,
	Vipin.Jain@amd.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 00/18] Introducing P4TC
Date: Mon, 16 Oct 2023 05:35:31 -0400
Message-Id: <20231016093549.181952-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are seeking community feedback on P4TC patches.

We have reduced the number of commits in this patchset including leaving out
all the testcases and secondary patches in order to ease review.

We feel we have completed the migration from the V1 scriptable version to eBPF
and now is a good time to remove the RFC tag.

Changes In RFC Version 2
-------------------------

Version 2 is the initial integration of the eBPF datapath.
We took into consideration suggestions provided to use eBPF and put effort into
analyzing eBPF as datapath which involved extensive testing.
We implemented 6 approaches with eBPF and ran performance analysis and presented
our results at the P4 2023 workshop in Santa Clara[see: 1, 3] on each of the 6
vs the scriptable P4TC and concluded that 2 of the approaches are sensible (4 if
you account for XDP or TC separately).

Conclusions from the exercise: We lose the simple operational model we had
prior to integrating eBPF. We do gain performance in most cases when the
datapath is less compute-bound.
For more discussion on our requirements vs journeying the eBPF path please
scroll down to "Restating Our Requirements" and "Challenges".

This patch set presented two modes.
mode1: the parser is entirely based on eBPF - whereas the rest of the
SW datapath stays as _scriptable_ as in Version 1.
mode2: All of the kernel s/w datapath (including parser) is in eBPF.

The key ingredient for eBPF, that we did not have access to in the past, is
kfunc (it made a big difference for us to reconsider eBPF).

In V2 the two modes are mutually exclusive (IOW, you get to choose one
or the other via Kconfig).

Changes In RFC Version 3
-------------------------

These patches are still in a little bit of flux as we adjust to integrating
eBPF. So there are small constructs that are used in V1 and 2 but no longer
used in this version. We will make a V4 which will remove those.
The changes from V2 are as follows:

1) Feedback we got in V2 is to try stick to one of the two modes. In this version
we are taking one more step and going the path of mode2 vs v2 where we had 2 modes.

2) The P4 Register extern is no longer standalone. Instead, as part of integrating
into eBPF we introduce another kfunc which encapsulates Register as part of the
extern interface.

3) We have improved our CICD to include tools pointed to us by Simon. See
   "Testing" further below. Thanks to Simon for that and other issues he caught.
   Simon, we discussed on issue [7] but decided to keep that log since we think
   it is useful.

4) A lot of small cleanups. Thanks Marcelo. There are two things we need to
   re-discuss though; see: [5], [6].

5) We removed the need for a range of IDs for dynamic actions. Thanks Jakub.

6) Clarify ambiguity caused by smatch in an if(A) else if(B) condition. We are
   guaranteed that either A or B must exist; however, lets make smatch happy.
   Thanks to Simon and Dan Carpenter.

Changes In RFC Version 4
-------------------------

1) More integration from scriptable to eBPF. Small bug fixes.

2) More streamlining support of externs via kfunc (one additional kfunc).

3) Removed per-cpu scratchpad per Toke's suggestion and instead use XDP metadata.

There is more eBPF integration coming. One thing we looked at but is not in this
patchset but should be in the next is use of eBPF link in our loading (see
"challenge #1" further below).

Changes In RFC Version 5
-------------------------

1) More integration from scriptable view to eBPF. Small bug fixes from last
   integration.

2) More streamlining support of externs via kfunc (create-on-miss, etc)

3) eBPF linking for XDP.

There is more eBPF integration/streamlining coming (we are getting close to
conversion from scriptable domain).

Changes In RFC Version 6
-------------------------

1) Completed integration from scriptable view to eBPF. Completed integration
   of externs integration.

2) Small bug fixes from v5 based on testing.

Changes In RFC Version 7
-------------------------

0) First time removing the RFC tag!

1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!) - that
using bpf links was sufficient to protect us from someone replacing or deleting
a eBPF program after it has been bound to a netdev.

2) Add some reviewed-bys from Vlad.

3) Small bug fixes from v6 based on testing for ebpf.

4) Added the counter extern as a sample extern. Illustrating this example because
   it is slightly complex since it is possible to invoke it directly from
   the P4TC domain (in case of direct counters) or from eBPF (indirect counters).
   It is not exactly the most efficient implementation (a reasonable counter impl
   should be per-cpu).

What is P4?
-----------

The Programming Protocol-independent Packet Processors (P4) is an open source,
domain-specific programming language for specifying data plane behavior.

The P4 ecosystem includes an extensive range of deployments, products, projects
and services, etc. For Details, visit: https://p4.org/

__What is P4TC?__

P4TC is an implementation of P4 building on top of many years of Linux TC
experiences. On why P4 - see small treatise here:[4].

There have been many discussions and meetings since about 2015 in regards to
P4 over TC [2] and we are finally proving the naysayers that we do get stuff
done!

A lot more of the P4TC motivation is captured at:
https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
Note: To be updated to describe integration with eBPF as datapath.

**In this patch series we focus on s/w datapath only**.

__P4TC Workflow__

These patches enable kernel and user space code change _independence_ for any
new P4 program that describes a new datapath. The workflow is as follows:

  1) A developer writes a P4 program, "myprog"

  2) Compiles it using the P4C compiler[8]. The compiler generates 3 outputs:
     a) shell script(s) which form template definitions for the different P4
     objects "myprog" utilizes (tables, externs, actions etc).
     b) the parser and the rest of the datapath are generated
     in eBPF and need to be compiled into binaries.
     c) A json introspection file used for the control plane (by iproute2/tc).

  3) The developer (or operator) executes the shell script(s) to manifest the
     functional s/w equivalent of "myprog" into the kernel.

  4) The developer (or operator) instantiates "myprog" via the tc P4 filter
     to ingress/egress (depending on P4 arch) of one or more netdevs/ports.

     Example1: parser is an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        action bpf obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example2: parser explicitly bound and rest of dpath as an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog tc obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example3: parser is at XDP, rest of dpath as an action:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog type xdp obj $PARSER.o section parser/xdp-ingress xdp_cookie 123 \
	pinned_link /path/to/xdp-prog-link \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example4: parser+prog at XDP:
       "tc filter add block 22 ingress protocol all prio 10 p4 pname myprog \
        prog type xdp obj $PROGNAME.o section p4prog/xdp xdp_cookie 123 \
	pinned_link /path/to/xdp-prog-link"

    see individual patches for more examples tc vs xdp etc. Also see section on
    "challenges".

Once "myprog" P4 program is instantiated one can start updating table entries
that are associated with myprog's table named "mytable". Example:

  tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
    action send_to_port param port eno1

A packet arriving on ingress of any of the ports on block 22 will first be
exercised via the (eBPF) parser to find the headers pointing to the ip
destination address.
The remainder eBPF datapath uses the result dstAddr as a key to do a lookup in
myprog's mytable which returns the action params which are then used to execute
the action in the eBPF datapath (eventually sending out packets to eno1).
On a table miss, mytable's default miss action is executed.

__Description of Patches__

P4TC is designed to have no impact on the core code for other users
of TC. IOW, you can compile it out or as a module and if you dont use
it then there should be no impact on your performance.

We do make core kernel changes. Patch #1 adds infrastructure for "dynamic"
actions that can be created on "the fly" based on the P4 program requirement.
This patch makes a small incision into act_api which shouldn't affect the
performance (or functionality) of the existing actions. Patches 2-4,6-7 are
minimalist enablers for P4TC and have no effect the classical tc action.
Patch 5 adds infrastructure support for preallocation of dynamic actions.

The core P4TC code implements several P4 objects.

1) Patch #8 introduces P4 data types which are consumed by the rest of the code
2) Patch #9 introduces the concept of templating Pipelines. i.e CRUD commands
   for P4 pipelines.
3) Patch #10 introduces the concept of P4 header fields and associated CRUD
   template commands.
4) Patch #11 introduces the concept of action templates and associated
   CRUD commands.
5) Patch #12 introduces the concept of P4 table templates and associated
   CRUD commands for tables
6) Patch #13 introduces table entries and associated CRUD commands.
7) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
8) Patch #15 introduces the TC classifier P4 used at runtime.
9) Patch #16 introduces extern interfacing (both template and runtime).
10) Patch #17 introduces primitive extern P4 counter(direct and indirect).

__Testing__

Speaking of testing - we have ~300 tdc test cases. This number is growing as
we are adjusting to accommodate for eBPF.
These tests are run on our CICD system on pull requests and after commits are
approved. The CICD does a lot of other tests (more since v2, thanks to Simon's
input)including:
checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds tested on both
X86, ARM 64 and emulated BE via qemu s390. We trigger performance testing in the
CICD to catch performance regressions (currently only on the control path, but
in the future for the datapath).
Syzkaller runs 24/7 on dedicated hardware, originally we focussed only on memory
sanitizer but recently added support for concurrency sanitizer.
Before main releases we ensure each patch will compile on its own to help in
git bisect and run the xmas tree tool. We eventually put the code via coverity.

In addition we are working on a tool that will take a P4 program, run it through
the compiler, and generate permutations of traffic patterns via symbolic
execution that will test both positive and negative datapath code paths. The
test generator tool is still work in progress and will be generated by the P4
compiler.
Note: We have other code that test parallelization etc which we are trying to
find a fit for in the kernel tree's testing infra.

__Restating Our Requirements__

Our original intention was to target the TC crowd for both s/w and h/w offload.
Essentially developers and ops people deploying TC based infra.
More importantly the original intent for P4TC was to enable _ops folks_ more than
devs (given code is being generated and doesn't need humans to write it).

With TC we get whole "familiar" package of match-action pipeline abstraction++,
meaning from the control plane to the tooling infra, iproute2/tc cli,
netlink messaging to s/w and h/w symbiosis, the autonomous kernel control, etc.
The advantage is that we have a singular vendor-neutral interface via the kernel
using well understood mechanisms based on deployment experience (therefore at
least this part doesnt need retraining).

1) Supporting expressibility of the universe set of P4 progs

It is a must to support 100% of all possible P4 programs. In the past the eBPF
verifier had to be worked around and even then there are cases where we couldnt
avoid path explosion when branching is involved. Kfunc-ing solves these issues
for us. Note, there are still challenges running all potential P4 programs at
the XDP level - the solution to that is to have the compiler generate XDP based
code only if it possible to map it to that layer.

2) Support for P4 HW and SW equivalence.

This feature continues to work even in the presence of eBPF as the s/w
datapath. There are cases of square-hole-round-peg scenarios but
those are implementation issues we can live with.

3) Operational usability

By maintaining the TC control plane (even in presence of eBPF datapath)
runtime aspects remain unchanged. So for our target audience of folks
who have deployed tc including offloads - the comfort zone is unchanged.

There is some loss in operational usability because we now have more knobs:
the extra compilation, loading and syncing of ebpf binaries, etc.
IOW, I can no longer just ship someone a shell script in an email to
say go run this and "myprog" will just work.

4) Operational and development Debuggability

If something goes wrong, the tc craftsperson is now required to have additional
knowledge of eBPF code and process. This applies to both the operational person
as well as someone who wrote a driver. We dont believe this is solvable.

5) Opportunity for rapid prototyping of new ideas

During the P4TC development phase something that came naturally was to often
handcode the template scripts because the compiler backend (which is P4 arch
specific) wasnt ready to generate certain things. Then you would read back the
template and diff to ensure the kernel didn't get something wrong. So this
started as a debug feature. During development, we wrote scripts that
covered a range of P4 architectures(PSA, V1, etc) which required no kernel code
changes.

Over time the debug feature morphed into: a) start by handcoding scripts then
b) read it back and then c) generate the P4 code.
It means one could start with the template scripts outside of the constraints
of a P4 architecture spec(PNA/PSA) or even within a P4 architecture then test
some ideas and eventually feed back the concepts to the compiler authors or
modify or create a new P4 architecture and share with the P4 standards folks.

To summarize in presence of eBPF: The debugging idea is still alive.
One could dump, with proper tooling(bpftool for example), the loaded eBPF code
and be able to check for differences. But this is not the interesting part.
The concept of going back from whats in the kernel to P4 is a lot more difficult
to implement mostly due to scoping of DSL vs general purpose. It may be lost.
We have been thinking of ways to use BTF and embedding annotations in the eBPF
code and binary but more thought is required and we welcome suggestions.

6) Performance

It is clear you gain better performance for the datapath with eBPF. Refer to
our results for the tests we did[1].
Note: for computationally complex programs this value diminishes i.e the
gap between XDP and TC eBPF or even in some cases scriptable approach is not
prominent; however, we do acknowledge there is an observable performance gain
as expected (compiled vs interpreted approach).

__Challenges__

1) When we have either the parser or part/whole of s/w datapath running in XDP
   then we need to make sure that the instantiation at the TC level is aware.
   Parsed headers are shared between the XDP and TC in a map. Any metadata
   generated at XDP is carried in the skb. This leads us to the need to make
   sure that noone unloads the XDP. Current approach (in this patch):
   We add a cookie field value at the XDP level and verify it at the TC level
   that it was indeed the program we loaded giving us the data. We also
   recommend that the P4 prog is run under its own bpf mount. Of course none
   of this would save us from a malicious actor with root access.
   We have implemented an approach (suggested by Toke) to instead listen to
   link events to detect if our program is removed or replaced. This approach
   is not in this patchset because we need to do more testing - it will be in
   the next update. We will end up getting rid of the cookie by then.

2) Concept of tc block in XDP is _very tedious_ to implement. It would be nice
   if we can use concept there as well, since we expect P4 to work with many
   ports. It will require some core patches to fix this.

3) Right now we are using "packed" construct to enforce alignment in kfunc data
   exchange; but we're wondering if there is potential to use BTF to understand
   parameters and their offsets and encode this information at the compiler
   level.

4) At the moment we are creating a static buffer of 128B to retrieve the action
   parameters. If you have a lot of table entries and individual(non-shared)
   action instances with actions that require very little (or no) param space
   a lot of memory is wasted. There may also be cases where 128B may not be
   enough; (likely this is something we can teach the P4C compiler). If we can
   have dynamic pointers instead for kfunc fixed length parameterization then
   this issue is resolvable.

5) See "Restating Our Requirements" #5.
   We would really appreciate ideas/suggestions, etc.

__References__

[1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
[2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historical-perspective-for-p4tc
[3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p4-implementation-approaches-and-evaluation
[4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4-and-how-does-p4-help-here
[5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
[6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
[7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
[8]https://github.com/p4lang/p4c/tree/main/backends/tc

Jamal Hadi Salim (18):
  net: sched: act_api: Introduce dynamic actions list
  net/sched: act_api: increase action kind string length
  net/sched: act_api: Update tc_action_ops to account for dynamic
    actions
  net/sched: act_api: add struct p4tc_action_ops as a parameter to
    lookup callback
  net: sched: act_api: Add support for preallocated dynamic action
    instances
  net: introduce rcu_replace_pointer_rtnl
  rtnl: add helper to check if group has listeners
  p4tc: add P4 data types
  p4tc: add template pipeline create, get, update, delete
  p4tc: add template header field create, get, delete, flush and dump
  p4tc: add action template create, update, delete, get, flush and dump
  p4tc: add template table create, update, delete, get, flush and dump
  p4tc: add runtime table entry create, update, get, delete, flush and
    dump
  p4tc: add set of P4TC table kfuncs
  p4tc: add P4 classifier
  p4tc: Add P4 extern interface
  p4tc: Add global counter extern
  MAINTAINERS: add p4tc entry

 MAINTAINERS                          |   15 +
 include/linux/bitops.h               |    1 +
 include/linux/rtnetlink.h            |   19 +
 include/net/act_api.h                |   22 +-
 include/net/p4tc.h                   |  816 ++++++++
 include/net/p4tc_ext_api.h           |  198 ++
 include/net/p4tc_types.h             |   87 +
 include/net/tc_act/p4tc.h            |   51 +
 include/uapi/linux/p4tc.h            |  405 ++++
 include/uapi/linux/p4tc_ext.h        |   36 +
 include/uapi/linux/pkt_cls.h         |   19 +
 include/uapi/linux/rtnetlink.h       |   18 +
 net/sched/Kconfig                    |   24 +
 net/sched/Makefile                   |    3 +
 net/sched/act_api.c                  |  195 +-
 net/sched/cls_api.c                  |    2 +-
 net/sched/cls_p4.c                   |  447 ++++
 net/sched/p4tc/Makefile              |    9 +
 net/sched/p4tc/externs/ext_Counter.c |  541 +++++
 net/sched/p4tc/p4tc_action.c         | 2305 +++++++++++++++++++++
 net/sched/p4tc/p4tc_bpf.c            |  397 ++++
 net/sched/p4tc/p4tc_ext.c            | 2194 ++++++++++++++++++++
 net/sched/p4tc/p4tc_hdrfield.c       |  586 ++++++
 net/sched/p4tc/p4tc_parser_api.c     |  150 ++
 net/sched/p4tc/p4tc_pipeline.c       |  711 +++++++
 net/sched/p4tc/p4tc_runtime_api.c    |  153 ++
 net/sched/p4tc/p4tc_table.c          | 1609 +++++++++++++++
 net/sched/p4tc/p4tc_tbl_entry.c      | 2827 ++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c       |  613 ++++++
 net/sched/p4tc/p4tc_tmpl_ext.c       | 2221 ++++++++++++++++++++
 net/sched/p4tc/p4tc_types.c          | 1247 ++++++++++++
 net/sched/p4tc/trace.c               |   10 +
 net/sched/p4tc/trace.h               |   44 +
 security/selinux/nlmsgtab.c          |   10 +-
 34 files changed, 17946 insertions(+), 39 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 include/net/p4tc_ext_api.h
 create mode 100644 include/net/p4tc_types.h
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 include/uapi/linux/p4tc.h
 create mode 100644 include/uapi/linux/p4tc_ext.h
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/Makefile
 create mode 100644 net/sched/p4tc/externs/ext_Counter.c
 create mode 100644 net/sched/p4tc/p4tc_action.c
 create mode 100644 net/sched/p4tc/p4tc_bpf.c
 create mode 100644 net/sched/p4tc/p4tc_ext.c
 create mode 100644 net/sched/p4tc/p4tc_hdrfield.c
 create mode 100644 net/sched/p4tc/p4tc_parser_api.c
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_table.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_ext.c
 create mode 100644 net/sched/p4tc/p4tc_types.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h

-- 
2.34.1


